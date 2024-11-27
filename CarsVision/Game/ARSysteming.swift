//
//  ARSysteming.swift
//  CarsVision
//
//  Created by Narek Aslanyan on 27.11.24.
//

import ARKit
import RealityKit
import SwiftUI

@MainActor
protocol ARSysteming {

  var isProviderSupported: Bool { get }
  var provider: DataProvider { get }
  var isReadyToRun: Bool { get }

  func attachToNode(_ node: Entity, content: RealityViewContent)
  func setup()
  func startTracking() async

}
