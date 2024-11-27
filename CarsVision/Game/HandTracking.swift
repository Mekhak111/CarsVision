//
//  HandTracking.swift
//  CarsVision
//
//  Created by Narek Aslanyan on 27.11.24.
//

import ARKit
import SwiftUI
import RealityKit

typealias HandTrackingCallBack = (HandTracking.HandInfo, HandTracking.HandInfo) -> Void
typealias HandTrackingObjectCallBack = (HandTracking.HandInfo, String) -> Void
typealias HandTrackingFollowCallBack = (HandTracking.HandInfo) -> Void
typealias HandTrackingGestureCallBack = (HandTracking.Gesture, Pose3D) -> Void

@Observable
@MainActor
class HandTracking: ARSysteming {

  private static var instance: HandTracking? = nil

  enum State {
    case none
    case active
    case inactive
  }

  enum Gesture {
    case heart
  }

  struct HandInfo {
    var chirality: HandAnchor.Chirality
    var joint: HandSkeleton.JointName
    var model: ModelEntity
    var follow: Bool
  }

  static var shared: HandTracking {
    if HandTracking.instance == nil {
      HandTracking.instance = HandTracking()
    }

    return HandTracking.instance!
  }

  var onJointCollision: HandTrackingCallBack?
  var onJointObjectCollision: HandTrackingObjectCallBack?
  var onJointFollowCallBack: HandTrackingFollowCallBack?
  var onGestureCallBack: HandTrackingGestureCallBack?

  let handTracking = HandTrackingProvider()

  private var trackingState = State.none
  private var parentNode: Entity?
  private var content: RealityViewContent?
  private var contentEntity = Entity()
  private var leftHandEntities: [HandSkeleton.JointName: HandInfo] = [:]
  private var rightHandEntities: [HandSkeleton.JointName: HandInfo] = [:]
  private var handEntities: [String: HandInfo] = [:]
  private var leftHand: HandAnchor?
  private var rightHand: HandAnchor?
  private var lastNameA = ""
  private var lastNameB = ""

  init() {
    print("HandTracking initialized")
  }

  var state: State {
    trackingState
  }

  var provider: DataProvider {
    handTracking
  }

  var isProviderSupported: Bool {
    HandTrackingProvider.isSupported
  }

  var isReadyToRun: Bool {
    handTracking.state == .initialized
  }

  func getHandInfo(name: String) -> HandInfo? {
    handEntities[name]
  }

  // MARK: Collision handling

  func handleCollision(nameA: String, nameB: String) {
    if trackingState != .active {
      return
    }

    // Check if previous call was opposite
    if nameA == lastNameB && nameB == lastNameA {
      return
    }

    if let infoA = handEntities[nameA], let infoB = handEntities[nameB] {
      // Collision between joints
      onJointCollision?(infoA, infoB)
    } else if let infoA = handEntities[nameA] {
      // Collision between joint and other object
      onJointObjectCollision?(infoA, nameB)
    } else if let infoB = handEntities[nameB] {
      // Collision between joint and other object
      onJointObjectCollision?(infoB, nameA)
    }

    lastNameA = nameA
    lastNameB = nameB
  }

  // MARK: Set joints to track

  func activateTracking(
    chirality: HandAnchor.Chirality,
    joint: HandSkeleton.JointName,
    follow: Bool = false
  ) {
    if parentNode == nil || content == nil {
      print(
        "Handtracking nodes are not attached to parent. Use attachToNode() before call activateTracking()"
      )
      return
    }

    var modelEntity: ModelEntity? = nil

    if joint == .forearmWrist {
      let mesh = MeshResource.generateBox(size: 0.06)
      let material = SimpleMaterial(color: UIColor.green, isMetallic: false)
      modelEntity = ModelEntity(mesh: mesh, materials: [material])

      let bounds = mesh.bounds.extents
      modelEntity?.components.set(
        CollisionComponent(shapes: [.generateBox(size: bounds)]))
    } else {
      let mesh = MeshResource.generateSphere(radius: 0.01)
      let material = SimpleMaterial(color: UIColor.red, isMetallic: false)
      modelEntity = ModelEntity(mesh: mesh, materials: [material])

      let bounds = mesh.bounds.extents
      modelEntity?.components.set(
        CollisionComponent(shapes: [.generateBox(size: bounds)]))
    }

    guard let entity = modelEntity else {
      fatalError("Model entity not created for Hand-tracking. STOP")
    }

    let key = "\(chirality)-\(joint)"
    entity.name = key

    // Disable to make it visible
    //entity.components.set(OpacityComponent(opacity: 0.0))

    // Add to parent
    contentEntity.addChild(entity)

    // Create info
    let info = HandInfo(chirality: chirality, joint: joint, model: entity, follow: follow)

    // Add to map
    if chirality == .left {
      leftHandEntities[joint] = info
    } else {
      rightHandEntities[joint] = info
    }

    // Add to info map
    handEntities[key] = info

    // Subscribe for collisions
    let _ = content!.subscribe(to: CollisionEvents.Began.self, on: entity) {
      ce in
      self.handleCollision(nameA: ce.entityA.name, nameB: ce.entityB.name)
    }
  }

  func attachToNode(_ node: Entity, content: RealityViewContent) {
    parentNode = node
    self.content = content

    parentNode?.addChild(contentEntity)
  }

  func setup() {
    // Does just some checks
    if parentNode == nil || content == nil {
      print("Handtracking nodes are not attached to parent. Use attachToNode() before call start()")
      return
    }

    if handEntities.isEmpty {
      print("Add some joints for tracking by using activateTracking() first ")
      return
    }
  }

  func startTracking() async {
    for await update in handTracking.anchorUpdates {
      let handAnchor = update.anchor

      if handAnchor.isTracked {
        trackingState = .inactive
        processHandJoints(handAnchor: handAnchor)
      } else {
        print("Hand anchor NOT tracked")
        trackingState = .inactive
      }
    }
  }

  func processHandJoints(handAnchor: HandAnchor) {
    if handAnchor.chirality == .left {
      leftHand = handAnchor

      for key in leftHandEntities.keys {
        if let joint = handAnchor.handSkeleton?.joint(key), joint.isTracked {
          let originFromJoint =
            handAnchor.originFromAnchorTransform * joint.anchorFromJointTransform
          leftHandEntities[key]?.model.setTransformMatrix(originFromJoint, relativeTo: nil)

          if leftHandEntities[key]!.follow {
            onJointFollowCallBack?(leftHandEntities[key]!)
          }

          trackingState = .active
        }
      }
    }

    if handAnchor.chirality == .right {
      rightHand = handAnchor

      for key in rightHandEntities.keys {
        if let joint = handAnchor.handSkeleton?.joint(key), joint.isTracked {
          let originFromJoint =
            handAnchor.originFromAnchorTransform
            * joint.anchorFromJointTransform
          rightHandEntities[key]?.model.setTransformMatrix(
            originFromJoint, relativeTo: nil)

          if rightHandEntities[key]!.follow {
            onJointFollowCallBack?(rightHandEntities[key]!)
          }

          trackingState = .active
        }
      }
    }

    if let m = processHeartGesture(), let pose = Pose3D(m) {
      onGestureCallBack?(.heart, pose)
    }
  }

  private func processHeartGesture() -> simd_float4x4? {
    // Get the latest hand anchors, return false if either of them isn't tracked.
    guard let leftHandAnchor = leftHand,
      let rightHandAnchor = rightHand,
      leftHand?.isTracked != nil,
      rightHand?.isTracked != nil
    else {
      return nil
    }

    // Get all required joints and check if they are tracked.
    guard
      let leftHandThumbKnuckle = leftHandAnchor.handSkeleton?.joint(.thumbKnuckle),
      let leftHandThumbTipPosition = leftHandAnchor.handSkeleton?.joint(.thumbTip),
      let leftHandIndexFingerTip = leftHandAnchor.handSkeleton?.joint(.indexFingerTip),
      let rightHandThumbKnuckle = rightHandAnchor.handSkeleton?.joint(.thumbKnuckle),
      let rightHandThumbTipPosition = rightHandAnchor.handSkeleton?.joint(.thumbTip),
      let rightHandIndexFingerTip = rightHandAnchor.handSkeleton?.joint(.indexFingerTip),
      leftHandIndexFingerTip.isTracked && leftHandThumbTipPosition.isTracked
        && rightHandIndexFingerTip.isTracked
        && rightHandThumbTipPosition.isTracked && leftHandThumbKnuckle.isTracked
        && rightHandThumbKnuckle.isTracked
    else {
      return nil
    }

    // Get the position of all joints in world coordinates.
    let originFromLeftHandThumbKnuckleTransform = matrix_multiply(
      leftHandAnchor.originFromAnchorTransform,
      leftHandThumbKnuckle.anchorFromJointTransform
    ).columns.3.xyz
    let originFromLeftHandThumbTipTransform = matrix_multiply(
      leftHandAnchor.originFromAnchorTransform,
      leftHandThumbTipPosition.anchorFromJointTransform
    ).columns.3.xyz
    let originFromLeftHandIndexFingerTipTransform = matrix_multiply(
      leftHandAnchor.originFromAnchorTransform,
      leftHandIndexFingerTip.anchorFromJointTransform
    ).columns.3.xyz
    let originFromRightHandThumbKnuckleTransform = matrix_multiply(
      rightHandAnchor.originFromAnchorTransform,
      rightHandThumbKnuckle.anchorFromJointTransform
    ).columns.3.xyz
    let originFromRightHandThumbTipTransform = matrix_multiply(
      rightHandAnchor.originFromAnchorTransform,
      rightHandThumbTipPosition.anchorFromJointTransform
    ).columns.3.xyz
    let originFromRightHandIndexFingerTipTransform = matrix_multiply(
      rightHandAnchor.originFromAnchorTransform,
      rightHandIndexFingerTip.anchorFromJointTransform
    ).columns.3.xyz

    let indexFingersDistance = distance(
      originFromLeftHandIndexFingerTipTransform,
      originFromRightHandIndexFingerTipTransform)
    let thumbsDistance = distance(
      originFromLeftHandThumbTipTransform, originFromRightHandThumbTipTransform)

    // Heart gesture detection is true when the distance between the index finger tips centers
    // and the distance between the thumb tip centers is each less than four centimeters.
    let isHeartShapeGesture = indexFingersDistance < 0.04 && thumbsDistance < 0.04
    if !isHeartShapeGesture {
      return nil
    }

    // Compute a position in the middle of the heart gesture.
    let halfway =
      (originFromRightHandIndexFingerTipTransform - originFromLeftHandThumbTipTransform) / 2
    let heartMidpoint = originFromRightHandIndexFingerTipTransform - halfway

    // Compute the vector from left thumb knuckle to right thumb knuckle and normalize (X axis).
    let xAxis = normalize(
      originFromRightHandThumbKnuckleTransform - originFromLeftHandThumbKnuckleTransform)

    // Compute the vector from right thumb tip to right index finger tip and normalize (Y axis).
    let yAxis = normalize(
      originFromRightHandIndexFingerTipTransform
        - originFromRightHandThumbTipTransform)

    let zAxis = normalize(cross(xAxis, yAxis))

    // Create the final transform for the heart gesture from the three axes and midpoint vector.
    let heartMidpointWorldTransform = simd_matrix(
      SIMD4(xAxis.x, xAxis.y, xAxis.z, 0),
      SIMD4(yAxis.x, yAxis.y, yAxis.z, 0),
      SIMD4(zAxis.x, zAxis.y, zAxis.z, 0),
      SIMD4(heartMidpoint.x, heartMidpoint.y, heartMidpoint.z, 1)
    )

    return heartMidpointWorldTransform
  }

}
