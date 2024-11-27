//
//  GameSpace.swift
//  CarsVision
//
//  Created by Narek Aslanyan on 27.11.24.
//

import RealityKit
import SwiftUI

struct GameSpace: View {

  @Environment(\.openImmersiveSpace) var openImmersiveSpace
  @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
  @Environment(\.openWindow) var openWindow
  @Environment(\.dismissWindow) var dismissWindow
  @Environment(\.appModel) var appModel
  @State private var viewModel = Car3DViewModel()
  @State var road: ModelEntity = ModelEntity()

  var body: some View {
    ZStack {
      Nature()
      RealityView { content, attachments in
        if let road = try? await ModelEntity(named: "Road") {
          self.road = road
        }
        road.position = [0, 0, 0]

        let radians = 90 * Float.pi / 180.0
        road.transform.rotation = simd_quatf(angle: radians, axis: SIMD3<Float>(0, 1, 0))

        content.add(road)
        guard let car = try? await ModelEntity(named: appModel.carModel.modelName),
          let attachment = attachments.entity(for: "attachment")
        else { return }
        attachment.position = SIMD3<Float>(0, 240, 0)
        attachment.scale = [1000, 1000, 1000]
        
        let attachmentRadians = 180 * Float.pi / 180.0
        attachment.transform.rotation = simd_quatf(angle: attachmentRadians, axis: SIMD3<Float>(0, 1, 0))
        
        car.addChild(attachment)

        viewModel.carEnt = car
        let sizes = viewModel.getSizes()
        let carWidth = sizes[0]
        let roadWidth = (road.model?.mesh.bounds.max.x ?? 0) - (road.model?.mesh.bounds.min.x ?? 0)
        let relativeScale = Double(roadWidth) / carWidth
        let scale = viewModel.calculateScale(for: sizes) * relativeScale

        viewModel.carEnt.position = [120, 10, 120]
        viewModel.carEnt.scale = [Float(scale), Float(scale), Float(scale)]
        let carRadians = 90 * Float.pi / 180.0
        viewModel.carEnt.transform.rotation = simd_quatf(
          angle: carRadians, axis: SIMD3<Float>(0, 1, 0))

        road.addChild(viewModel.carEnt)
        let gameObject = GameObject(entity: viewModel.carEnt)
        GameController.shared.carObject = gameObject
        ARSession.shared.startSession(systems: [
          HeadPose.shared, HandTracking.shared,
        ])
        setupHandTracking(content: content)
      } attachments: {
        Attachment(id: "attachment") {
          if appModel.state == .placeCar {
            placeCarButton
          }
        }
      }
    }
  }

  private var placeCarButton: some View {
    Button {
      placeObjectAtHeadPose()
    } label: {
      Text("Place Car")
        .font(.largeTitle)
        .fontWeight(.regular)
        .padding()
        .cornerRadius(8)
    }
    .padding()
    .buttonStyle(.bordered)
  }

  // MARK: - Hand-tracking

  @MainActor
  private func setupHandTracking(content: RealityViewContent) {
    // Anchor used for hand tracking
    let node = Entity()
    node.position = [0, 0, 0]
    content.add(node)
    print("Created entity for hand-tracking at 0,0,0")

    // Hand-tracking functionality
    HandTracking.shared.attachToNode(node, content: content)

    // Activate handtracking for this joints
    HandTracking.shared.activateTracking(chirality: .left, joint: .indexFingerTip)
    HandTracking.shared.activateTracking(chirality: .left, joint: .thumbTip)
    HandTracking.shared.activateTracking(chirality: .right, joint: .indexFingerTip)
    HandTracking.shared.activateTracking(chirality: .right, joint: .thumbTip)

    HandTracking.shared.onJointCollision = { (infoA, infoB) in
      // A/B combination
      if infoA.chirality == .left && infoA.joint == .indexFingerTip
        && infoB.chirality == .left && infoB.joint == .thumbTip
      {
        // Left index finger on left thumb
        GameController.shared.changeDirection(by: -10.0)
      } else if infoA.chirality == .right && infoA.joint == .indexFingerTip
        && infoB.chirality == .right && infoB.joint == .thumbTip
      {
        // Right index finger on left thumb
        GameController.shared.changeDirection(by: 10.0)
      }
      // B/A combination
      else if infoB.chirality == .left && infoB.joint == .indexFingerTip
        && infoA.chirality == .left && infoA.joint == .thumbTip
      {
        // Left index finger on left thumb
        GameController.shared.changeDirection(by: -10.0)
      } else if infoB.chirality == .right && infoB.joint == .indexFingerTip
        && infoA.chirality == .right && infoA.joint == .thumbTip
      {
        // Right index finger on left thumb
        GameController.shared.changeDirection(by: 10.0)
      }
    }

    HandTracking.shared.setup()
  }

  private func placeObjectAtHeadPose() {
    if appModel.state == .placeCar {
      placeCarAtHeadPose()
    }
  }

  private func placeCarAtHeadPose() {
    var position = HeadPose.shared.position
    position.x = position.x + 50
    position.y = position.y + 7
    position.z = position.z + 50
    viewModel.carEnt.position = position
    viewModel.carEnt.isEnabled = true
    GameController.shared.setCarPosition(position)
    appModel.state = .placed
  }

}
