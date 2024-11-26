//
//  LunchScreen.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/14/24.
//

import SwiftUI

struct LunchScreen: View {
  
  @Environment(\.openImmersiveSpace) private var openImmersiveSpace
  @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
  
  @State var isAutoSalonOpened: Bool = false
  
  var body: some View {
    NavigationStack {
      VStack {
        Text("Find Your Nissan")
          .font(.extraLargeTitle)
          .foregroundStyle(Color.white)
        
        Text("Adventure calls")
          .font(.extraLargeTitle2)
          .foregroundStyle(Color.white)
        if !isAutoSalonOpened {
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
        }
        
        Button {
          Task {
            if isAutoSalonOpened {
              await dismissImmersiveSpace.callAsFunction()
            } else {
              await openImmersiveSpace.callAsFunction(id: "Autosalon")
            }
            isAutoSalonOpened.toggle()
          }
        } label: {
          Text(isAutoSalonOpened ? "Exit Auto Salon" : "Visit Auto Salon")
        }
        .padding(.top, 30)
      }
    }
  }
  
}

#Preview {
  LunchScreen()
}
