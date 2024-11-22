//
//  CarModelInVolumetric.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/22/24.
//

import SwiftUI
import RealityKit

struct CarModelInVolumetric: View {
  
  @Environment(\.appModel) private var appModel
  
  var body: some View {
    Model3D(named: appModel.carModel.modelName) { car in
      car
        .resizable()
    }
    placeholder: {
      ProgressView()
        .progressViewStyle(.circular)
    }
  }
  
}

#Preview {
    CarModelInVolumetric()
}
