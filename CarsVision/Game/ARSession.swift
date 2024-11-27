//
//  ARSession.swift
//  CarsVision
//
//  Created by Narek Aslanyan on 27.11.24.
//

import Foundation
import ARKit

@MainActor
class ARSession {

  private static var instance: ARSession? = nil
  private var session = ARKitSession()
  private var providers: [DataProvider] = []
  private var hasError = false // Must be changed to later to track errors by each provider

  static var shared: ARSession {
    if ARSession.instance == nil {
      ARSession.instance = ARSession()
    }

    return ARSession.instance!
  }

  func startSession(systems: [ARSysteming]) {
    #if !os(visionOS) && !targetEnvironment(simulator)
      print("ARSystem just works on VisionPro device")
      return
    #endif

    providers.removeAll()

    for system in systems {
      if system.isProviderSupported && system.isReadyToRun {
        providers.append(system.provider)
      }
    }

    if providers.count == 0 {
      print("No ARSystems found that are ready to run")
    }
    Task {
      print("Start ARSystem(s)")
      try await session.run(providers)
    }

    Task {
      await self.monitorSessionEvents()
    }

    for system in systems {
      Task {
        await system.startTracking()
      }
    }
  }

  // Responds to events like authorization revocation.
  private func monitorSessionEvents() async {
    for await event in session.events {
      switch event {
      case .authorizationChanged(type: _, let status):
        print("Authorization changed to: \(status)")
        if status == .denied {
          hasError = true
        }
      case .dataProviderStateChanged(
        dataProviders: let providers, newState: let state, let error):
        print("Data provider changed: \(providers), \(state)")
        if let error {
          print("Data provider reached an error state: \(error)")
          hasError = true
        }
      @unknown default:
        print("Unhandled new event type \(event)")
      }
    }
  }

}
