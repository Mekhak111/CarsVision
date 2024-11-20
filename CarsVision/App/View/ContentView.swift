//
//  ContentView.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/14/24.
//

import RealityKit
import RealityKitContent
import SwiftUI

struct ContentView: View {

  var body: some View {
    VStack {
      Model3D(named: "Scene", bundle: realityKitContentBundle)
        .padding(.bottom, 50)

      Text("Hello, world!")

      ToggleImmersiveSpaceButton()
    }
    .padding()
  }
  
}

#Preview(windowStyle: .automatic) {
  ContentView()
    .environment(AppModel())
}
