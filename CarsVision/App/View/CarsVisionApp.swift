//
//  CarsVisionApp.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/14/24.
//

import SwiftUI
import RealityKit

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
    
    WindowGroup(id: "Picker") {
      PickerMaterial()
        .environment(appModel)
        .presentationCornerRadius(20)
        .glassBackgroundEffect()

    }
    .windowStyle(.plain)
    .defaultSize(CGSize(width: 400, height: 400))
    
    ImmersiveSpace(id: appModel.immersiveSpaceID) {
      GarageSystem()
        .environment(appModel)
    }
    .immersionStyle(selection: .constant(.full), in: .full)
    }
  
}
