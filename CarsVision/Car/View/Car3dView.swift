//
//  Car3dView.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/15/24.
//

import RealityKit
import SwiftUI

struct Car3dView: View {
  @State private var scale = false

  var ent: Entity? = nil

  init() {
    ent = try? ModelEntity.load(named: "Car.usdz")
  }

  var body: some View {
    RealityView { content in
      if let robot = try? await ModelEntity(named: "Car") {
        content.add(robot)
      }
    }
  }

}

#Preview {
  Car3dView()
}

struct CarModel: View {

  @Environment(\.appModel) private var appModel

  var body: some View {
    GeometryReader3D { geometry in
      RealityView { content in
        if let car = try? await ModelEntity(named: appModel.carModel.modelName)
        {
          let bounds = content.convert(
            geometry.frame(in: .local),
            from: .local,
            to: content
          )
          let minExtent = bounds.extents.min()
          car.scale = [minExtent * 0.1, minExtent * 0.1, minExtent * 0.1]
          let carAnchor = AnchorEntity(world: [0, 0, 0.5])
          carAnchor.addChild(car)
          content.add(carAnchor)
        }
      }
    }
  }
}
