//
//  CarCardView.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/14/24.
//

import SwiftUI

struct CarCardView: View {
  let model: NissanModel
  var body: some View {
    NavigationLink(value: model) {
      
      VStack {
        Text(model.name)
          .font(.title)
          .padding(.bottom, 10)
          .foregroundStyle(Color.white)
        Text(model.description)
          .font(.headline)
          .padding(16)
          .foregroundStyle(Color.white)
      }
    }
    .buttonStyle(.borderless)
    .buttonBorderShape(.roundedRectangle(radius: 20))
    
  }
}

#Preview {
  HStack {
    CarCardView(model: .fairladyZRZ34_2023)
    CarCardView(model: .kicks2019)
    CarCardView(model: .kicks2021)
    CarCardView(model: .muranoHybrid2015)
  }
  
}
