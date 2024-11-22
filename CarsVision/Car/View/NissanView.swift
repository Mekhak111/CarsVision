//
//  NissanView.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/21/24.
//

import RealityKit
import SwiftUI

struct NissanView: View {
  
  @Environment(\.appModel) var appModel
  @State private var carEntity: CarEntity?
  
  var configuration: CarEntity.Configuration = .init()

  var body: some View {
    RealityView { content in
      let carEntity = await CarEntity(
        cartype: appModel.carModel, configuration: configuration)
      self.carEntity = carEntity

    } update: { content in
      carEntity?.update(configuration: configuration)
    }
  }
}

#Preview {
  NissanView()
}
