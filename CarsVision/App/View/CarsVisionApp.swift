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

  var body: some SwiftUI.Scene {
    WindowGroup {
      LunchScreen()
        .environment(appModel)
        .background(alignment: Alignment(horizontal: .center, vertical: .center)) {
          Image("car.background")
            .resizable()
            .scaledToFill()
        }
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
    .defaultSize(CGSize(width: 300, height: 300))

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
    }
    .immersionStyle(selection: .constant(.full), in: .full)

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
