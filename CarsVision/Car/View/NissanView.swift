//
//  NissanView.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/21/24.
//

import SwiftUI
import RealityKit

struct NissanView: View {
  @Environment(\.appModel) var appModel

  var configuration: CarEntity.Configuration = .init()
  
  @State private var carEntity: CarEntity?

  
    var body: some View {
      RealityView { content in

        let carEntity = await CarEntity(cartype: appModel.carModel, configuration: configuration)
        self.carEntity = carEntity

      } update: { content in
        carEntity?.update(configuration: configuration)
      }

    }
}

#Preview {
    NissanView()
}
