//
//  WheelsSelectionView.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/22/24.
//

import SwiftUI

struct WheelsSelectionView: View {
  var wheels: [String] = [
    "Rotiform_Aerodisc",
    "Rotiform_AVS",
    "Rotiform_KB1",
    "Rotiform_SIX",
    "Rotiform_ZMO"
  ]
  var body: some View {
    TabView {
      ForEach(wheels, id: \.self) { wheel in
        WheelVolumetricView(wheelName: wheel)
          .padding(30)
          .frame(maxWidth: 400)
          .frame(maxHeight: 400)
      }
    }
    .tabViewStyle(.page)
  }
}

#Preview {
  WheelsSelectionView()
}
