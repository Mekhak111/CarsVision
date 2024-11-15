//
//  LunchScreen.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/14/24.
//

import SwiftUI

struct LunchScreen: View {
    var body: some View {
      NavigationStack {
        VStack {
          Text("Find Your Nissan")
            .font(.extraLargeTitle)
            .foregroundStyle(Color.gray)
          Text("Adventure calls")
            .font(.extraLargeTitle2)
            .foregroundStyle(Color.gray)
          
          
          HStack {
            ForEach(NissanModel.allCases, id: \.name) { carType in
              CarCardView(model: carType)
                .padding(16)
            }
          }
          .navigationDestination(for: NissanModel.self) { module in
            CarDetailsScreen(carModel: module)
          }
          
        }
        .background(alignment: Alignment(horizontal: .center, vertical: .center)) {
          Image("car.background")
            .resizable()
            .scaledToFill()
        }
      }

      
    }
}

#Preview {
    LunchScreen()
}
