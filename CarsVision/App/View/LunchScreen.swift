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
        Spacer()
        
        Text("Find Your Nissan")
          .font(.extraLargeTitle)
          .foregroundStyle(Color.white)
        
        Text("Adventure calls")
          .font(.extraLargeTitle2)
          .foregroundStyle(Color.white)
        
        Spacer()
        
        if !isAutoSalonOpened {
          ScrollView(.horizontal) {
            Spacer()
            HStack(spacing: 0) {
              ForEach(NissanModel.allCases, id: \.name) { carType in
                CarCardView(model: carType)
                  .frame(width: 300, height: 250)
                  .padding(.horizontal, 30)
              }
            }
            .padding(.horizontal, 30)
            .navigationDestination(for: NissanModel.self) { module in
              CarDetailsScreen(viewModel: CarDetailsViewModel(carModel: module))
            }
            Spacer()
          }
          .frame(height: 350)
        }
        
        Spacer()
        
        HoverButtonView(
          primaryText: isAutoSalonOpened ? "Exit Autosalon" : "Visit AutoSalon",
          secondaryText: isAutoSalonOpened ? "Explore in App" : "9 cars available",
          iconName: isAutoSalonOpened ? "arrowshape.backward.circle.fill" : "car.circle.fill"
        ) {
          Task {
            if isAutoSalonOpened {
              await dismissImmersiveSpace.callAsFunction()
            } else {
              await openImmersiveSpace.callAsFunction(id: "Autosalon")
            }
            isAutoSalonOpened.toggle()
          }
        }
        
        Spacer()
      }
    }
  }
  
}

#Preview {
  LunchScreen()
}
