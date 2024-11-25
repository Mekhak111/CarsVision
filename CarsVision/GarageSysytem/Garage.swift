//
//  Garage.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/21/24.
//

import RealityKit
import RealityKitContent
import SwiftUI

struct Garage: View {

  var body: some View {
    RealityView { content in
      guard let resource = try? await TextureResource(named: "car_workshop_8k") else {
          fatalError("Unable to load car texture.")
      }
      var material = UnlitMaterial()
      material.color = .init(texture: .init(resource))

      let entity = Entity()
      entity.components.set(
        ModelComponent(
          mesh: .generateSphere(radius: 1000),
          materials: [material]
      ))
      entity.scale *= .init(x: -1, y: 1, z: 1)
      content.add(entity)
    }
  }
  
}

#Preview {
  Garage()
}
