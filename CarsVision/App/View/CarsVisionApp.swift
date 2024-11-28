//
//  CarsVisionApp.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/14/24.
//

import ARKit
import RealityKit
import RealityKitContent
import SwiftUI

enum Window: String {

  case game
  case car
  case picker
  case textures
  case wheels

}

@main
struct CarsVisionApp: App {

  private static var openedWindows: Set<Window> = []

  @State private var appModel = AppModel()

  private let session = ARKitSession()
  private let provider = HandTrackingProvider()
  private let rootEntity = Entity()

  var body: some SwiftUI.Scene {
    WindowGroup {
      OrnamentView()
        .environment(appModel)
    }

    WindowGroup(id: Window.car.rawValue) {
      CarModelInVolumetric()
        .environment(appModel)
        .onDisappear {
          CarsVisionApp.openedWindows.remove(.car)
        }
    }
    .windowStyle(.volumetric)
    .defaultSize(CGSize(width: 600, height: 600))

    WindowGroup(id: Window.picker.rawValue) {
      PickerMaterial()
        .environment(appModel)
        .presentationCornerRadius(20)
        .glassBackgroundEffect()
        .onDisappear {
          CarsVisionApp.openedWindows.remove(.picker)
        }
    }
    .windowStyle(.plain)
    .defaultSize(CGSize(width: 400, height: 400))

    WindowGroup(id: Window.textures.rawValue) {
      TexturesView()
        .environment(appModel)
        .presentationCornerRadius(20)
        .glassBackgroundEffect()
        .onDisappear {
          CarsVisionApp.openedWindows.remove(.textures)
        }
    }
    .windowStyle(.plain)
    .defaultSize(CGSize(width: 800, height: 800))

    WindowGroup(id: Window.wheels.rawValue) {
      WheelsSelectionView()
        .environment(appModel)
        .onDisappear {
          CarsVisionApp.openedWindows.remove(.wheels)
        }
    }
    .windowStyle(.volumetric)
    .defaultSize(CGSize(width: 600, height: 600))

    WindowGroup(id: Window.game.rawValue) {
      GameWindow()
        .environment(appModel)
        .onDisappear {
          CarsVisionApp.openedWindows.remove(.game)
        }
    }
    .defaultSize(CGSize(width: 400, height: 400))

    ImmersiveSpace(id: appModel.immersiveSpaceID) {
      GarageSystem()
        .environment(appModel)
    }
    .immersionStyle(selection: .constant(.full), in: .full)

    ImmersiveSpace(id: "game_space") {
      GameSpace()
        .environment(appModel)
    }
    .immersionStyle(selection: .constant(.full), in: .full)

    ImmersiveSpace(id: "Autosalon") {
      AutoSalon()
        .environment(appModel)
    }
    .immersionStyle(selection: .constant(.full), in: .full)

//    handTrackingImmersiveSpace
  }

  private var handTrackingImmersiveSpace: some SwiftUI.Scene {
    ImmersiveSpace(id: "HandTracking") {
      RealityView { content in
        content.add(rootEntity)
        for chirality in [HandAnchor.Chirality.left, .right] {
          for jointName in HandSkeleton.JointName.allCases {
            let jointEntity = ModelEntity(
              mesh: .generateSphere(radius: 0.006),
              materials: [SimpleMaterial()])
            jointEntity.name = "\(jointName)\(chirality)"
            rootEntity.addChild(jointEntity)
          }
        }
      }
      .task { try? await session.run([provider]) }
      .task {
        for await update in provider.anchorUpdates {
          let handAnchor = update.anchor
          for jointName in HandSkeleton.JointName.allCases {
            guard let joint = handAnchor.handSkeleton?.joint(jointName),
              let jointEntity = rootEntity.findEntity(named: "\(jointName)\(handAnchor.chirality)")
            else {
              continue
            }
            jointEntity.setTransformMatrix(
              handAnchor.originFromAnchorTransform * joint.anchorFromJointTransform,
              relativeTo: nil)
          }
        }
      }
    }
    .upperLimbVisibility(.hidden)
  }

  static func getOpenedWindows() -> Set<Window> {
    openedWindows
  }

  static func openWindowIfCan(by window: Window, handler: () -> Void) {
    guard !openedWindows.contains(window) else { return }
    openedWindows.insert(window)
    handler()
  }

  static func closeWindow(by window: Window, handler: () -> Void) {
    guard openedWindows.contains(window) else { return }
    CarsVisionApp.openedWindows.remove(window)
    handler()
  }

}
