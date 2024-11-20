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
    
    ImmersiveSpace(id: appModel.immersiveSpaceID) {
      CarModel()
        .environment(appModel)
    }
  }
  
}
