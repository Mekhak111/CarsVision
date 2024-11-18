//
//  Car3dView.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/15/24.
//

import SwiftUI
import RealityKit

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
