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
  @State private var rotation: Angle2D = Angle2D(.zero)
  
  var body: some View {
    Model3D(named: appModel.carModel.modelName) { car in
      car
        .resizable()
        .frame(maxWidth: 200)
        .frame(maxHeight: 200)
        .frame(maxDepth: 300)
        .padding()
        .rotation3DEffect(
          Rotation3D(
            eulerAngles: EulerAngles(x: Angle2D(.zero), y: rotation, z: Angle2D(.zero), order: .xyz))
        )
        .gesture(
          DragGesture()
            .onChanged { value in
              rotation += Angle2D(Angle(degrees: Double(value.translation.width)*0.1))
            }
        )
      
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
