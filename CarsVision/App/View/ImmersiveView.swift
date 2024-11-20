//
//  ImmersiveView.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/14/24.
//

import RealityKit
import RealityKitContent
import SwiftUI

struct ImmersiveView: View {

  @Environment(\.appModel) var appModel

  var ent: Entity? = nil

  init() {
    ent = try? ModelEntity.load(named: "Altima")
  }

  var body: some View {
    RealityView { content in
      if let ent {
        let anchorEntity = AnchorEntity(world: [0, 0, 0])
        anchorEntity.addChild(ent)
        content.add(anchorEntity)
      }
    }
  }
}

#Preview(immersionStyle: .full) {
  ImmersiveView()
    .environment(AppModel())
}
