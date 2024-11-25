//
//  CarsVisionApp.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/14/24.
//

import RealityKit
import SwiftUI

@main
struct CarsVisionApp: App {
  
  @State private var appModel = AppModel()
  
  var body: some SwiftUI.Scene {
    WindowGroup {
      LunchScreen()
        .environment(appModel)
    }

    WindowGroup(id: "Car") {
      CarModelInVolumetric()
        .environment(appModel)
    }
    .windowStyle(.volumetric)
    .defaultSize(CGSize(width: 600, height: 600))
    
    WindowGroup(id: "Picker") {
      PickerMaterial()
        .environment(appModel)
        .presentationCornerRadius(20)
        .glassBackgroundEffect()
    }
    .windowStyle(.plain)
    .defaultSize(CGSize(width: 400, height: 400))
    
    WindowGroup(id: "Textures") {
      TexturesView()
        .environment(appModel)
        .presentationCornerRadius(20)
        .glassBackgroundEffect()
    }
    .windowStyle(.plain)
    .defaultSize(CGSize(width: 800, height: 800))
    
    WindowGroup(id: "Wheels") {
      WheelsSelectionView()
        .environment(appModel)
    }
    .windowStyle(.volumetric)
    .defaultSize(CGSize(width: 600, height: 600))
    
    ImmersiveSpace(id: appModel.immersiveSpaceID) {
      GarageSystem()
        .environment(appModel)
    }
    .immersionStyle(selection: .constant(.full), in: .full)
  }

}
