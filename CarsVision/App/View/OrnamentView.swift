//
//  OrnamentView.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/26/24.
//

import SwiftUI

struct OrnamentView: View {
  var body: some View {
    TabView {
      LunchScreen()
        .background(alignment: Alignment(horizontal: .center, vertical: .center)) {
          Image("car.background")
            .resizable()
            .scaledToFill()
        }
        .tabItem {
          Label("Nissan", systemImage: "car")
        }
      
      PriceListView()
        .background(alignment: Alignment(horizontal: .center, vertical: .center)) {
          Image("NissanBackground")
            .resizable()
            .scaledToFill()
        }
        .tabItem {
          Label("Price List", systemImage: "list.bullet.clipboard")
        }
    }
  }
}

#Preview {
  OrnamentView()
}
