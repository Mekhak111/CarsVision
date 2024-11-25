//
//  WheelVolumetricView.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/22/24.
//

import SwiftUI
import RealityKit

struct WheelVolumetricView: View {
  var wheelName: String
    var body: some View {
      Model3D(named: wheelName) { content in
        content
          .resizable()
      } placeholder: {
        ProgressView()
          .progressViewStyle(.circular)
      }
    }
}

#Preview {
  WheelVolumetricView(wheelName: "")
}
