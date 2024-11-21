//
//  GarageSysytem.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/21/24.
//

import SwiftUI

struct GarageSystem: View {
  @Environment(\.appModel) var appModel
  var body: some View {
    ZStack {
      CarModel()
      Garage()
    }
  }
}

#Preview {
  GarageSystem()
}
