//
//  CarDetailsScreen.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/14/24.
//

import SwiftUI

struct CarDetailsScreen: View {
  @Environment(\.openWindow) private var openWindow
  @Environment(\.dismissWindow) private var dismissWindow
  
  var carModel: NissanModel
  
    var body: some View {
      HStack{
        VStack(alignment: .leading, spacing: 20) {
          Text(carModel.name)
            .font(.extraLargeTitle)
            .foregroundStyle(Color.white)
          
          Text(carModel.description)
            .font(.extraLargeTitle2)
            .foregroundStyle(Color.white)
          
          Text("HP \(carModel.horsepower)")
            .font(.title)
            .foregroundStyle(Color.white)
          
          Text(carModel.technicalSpecifications)
            .foregroundStyle(Color.white)
            .font(.title2)
          
          Button {
            openWindow(id: "Car")
          } label: {
            Text("Show 3D Model")
          }
        }
        Image("nissan.gtr")
            .resizable()
            .scaledToFit()
          }
      .padding()

    }
}

#Preview {
  CarDetailsScreen(carModel: .kicks2019)
}
