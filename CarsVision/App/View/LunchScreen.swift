//
//  LunchScreen.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/14/24.
//

import SwiftUI

struct LunchScreen: View {
  
  @Environment(\.openImmersiveSpace) private var openImmersiveSpace
  
  var body: some View {
    NavigationStack {
      VStack {
        Text("Find Your Nissan")
          .font(.extraLargeTitle)
          .foregroundStyle(Color.white)
        
        Text("Adventure calls")
          .font(.extraLargeTitle2)
          .foregroundStyle(Color.white)
        
        ScrollView(.horizontal) {
          HStack {
            ForEach(NissanModel.allCases, id: \.name) { carType in
              CarCardView(model: carType)
                .glassBackgroundEffect()
                .padding(16)
                .frame(maxWidth: 400)
            }
          }
          .navigationDestination(for: NissanModel.self) { module in
            CarDetailsScreen(viewModel: CarDetailsViewModel(carModel: module))
          }
        }
        
        Button {
          Task {
            await openImmersiveSpace.callAsFunction(id: "Autosalon")
          }
        } label: {
          Text("Visit Auto Salon")
        }
        .padding(.top, 30)
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
