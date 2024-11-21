//
//  RoadSystem.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/21/24.
//

import SwiftUI

struct RoadSystem: View {
  @Environment(\.appModel) var appModel
  var body: some View {
    ZStack {
      NissanView(
        configuration:
          CarEntity.Configuration(
            scale: 1,
            speed: 0.02,
            position: [-2, 0.4, -5]
          )
      )
      
      
    }
  }
}

#Preview {
  RoadSystem()
}
