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
        
        HoverButtonView(
          primaryText: isAutoSalonOpened ? "Exit Autosalon" : "Visit AutoSalon",
          secondaryText: isAutoSalonOpened ? "Explore in App" : "9 cars available",
          iconName: isAutoSalonOpened ? "arrowshape.backward.circle.fill" : "car.circle.fill",
          action: {
          Task {
            if isAutoSalonOpened {
              await dismissImmersiveSpace.callAsFunction()
            } else {
              await openImmersiveSpace.callAsFunction(id: "Autosalon")
            }
            isAutoSalonOpened.toggle()
          }
        })
      }
    }
  }
  
}

#Preview {
  LunchScreen()
}
