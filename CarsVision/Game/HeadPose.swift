//
//  HeadPose.swift
//  CarsVision
//
//  Created by Narek Aslanyan on 27.11.24.
//

import ARKit
import SwiftUI
import RealityKit

@Observable
class HeadPose: ARSysteming {
  private static var instance: HeadPose? = nil

  let worldTracking = WorldTrackingProvider()
  var transform = simd_float4x4()

  static var shared: HeadPose {
    if HeadPose.instance == nil {
      HeadPose.instance = HeadPose()
    }

    return HeadPose.instance!
  }

  var position: SIMD3<Float> {
    var pos = SIMD3<Float>()
    pos.x = transform.columns.3.x
    pos.y = transform.columns.3.y
    pos.z = transform.columns.3.z

    return pos
  }

  var provider: DataProvider {
    return worldTracking
  }

  var isProviderSupported: Bool {
    WorldTrackingProvider.isSupported
  }

  var isReadyToRun: Bool {
    worldTracking.state == .initialized
  }

  func attachToNode(_ node: Entity, content: RealityViewContent) {
    // Used for visualisation if needed
  }

  func setup() {
    // Used for setup if needed
  }

  func startTracking() async {
    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
      Task {
        await self.updateMatrix()
      }
    }
  }

  private func updateMatrix() async {
    guard let deviceAnchor = worldTracking.queryDeviceAnchor(atTimestamp: CACurrentMediaTime())
    else {
      print("Can't get device anchor")
      return
    }
    transform = deviceAnchor.originFromAnchorTransform
    print("Device: \(transform)")
  }
}
