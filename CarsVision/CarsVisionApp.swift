//
//  CarsVisionApp.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/14/24.
//

import SwiftUI

@main
struct CarsVisionApp: App {

    @State private var appModel = AppModel()

    var body: some Scene {
      
        WindowGroup {
          LunchScreen()
                .environment(appModel)
        }
      
      WindowGroup(id: "Car") {
        Car3dView()
          .environment(appModel)
      }.windowStyle(.volumetric)
     

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.full), in: .full)
    }
}
