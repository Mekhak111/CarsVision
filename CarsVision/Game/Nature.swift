//
//  Nature.swift
//  CarsVision
//
//  Created by Narek Aslanyan on 27.11.24.
//

import SwiftUI
import RealityKit

struct Nature: View {

  var body: some View {
    RealityView { content in
      guard let resource = try? await TextureResource(named: "nature4k") else {
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
