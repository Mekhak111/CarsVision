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
  @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
  @Environment(\.openImmersiveSpace) private var openImmersiveSpace
  @Environment(\.appModel) private var appModel
  @State private var viewModel: CarDetailsViewModel
  
  init(viewModel: CarDetailsViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 20) {
        Text(viewModel.carModel.name)
          .font(.extraLargeTitle)
          .foregroundStyle(Color.white)

        Text(viewModel.carModel.description)
          .font(.extraLargeTitle2)
          .foregroundStyle(Color.white)

        Text("HP \(viewModel.carModel.horsepower)")
          .font(.title)
          .foregroundStyle(Color.white)

        Text(viewModel.carModel.technicalSpecifications)
          .foregroundStyle(Color.white)
          .font(.title2)
        HStack {
          HoverButtonView(primaryText: viewModel.isShowModel ? "Dismiss 3D Model" : "Show 3D Model", secondaryText: "", iconName: "car.fill") {
            viewModel.isShowModel.toggle()
            appModel.carModel = viewModel.carModel
            showWindow()
          }
          HoverButtonView(primaryText: viewModel.isShowImmersive ? "Dismiss Imersive" : "Show Imersive", secondaryText: "", iconName: "figure.2.circle") {
            viewModel.isShowImmersive.toggle()
            appModel.carModel = viewModel.carModel
            showImmersiveSpace()
          }
        }
      }
      Image("nissan.gtr")
        .resizable()
        .scaledToFit()
    }
    .navigationBarBackButtonHidden(viewModel.isShowImmersive)
    .padding()
  }

  private func showWindow() {
    if viewModel.isShowModel {
      openWindow(id: "Car")
    } else {
      dismissWindow(id: "Car")
    }
  }

  private func showImmersiveSpace() {
    if viewModel.isShowImmersive {
      Task {
        await openImmersiveSpace(id: appModel.immersiveSpaceID)
      }
    } else {
      Task {
        await dismissImmersiveSpace()
      }
    }
  }

}

#Preview {
  CarDetailsScreen(viewModel: CarDetailsViewModel(carModel: NissanModel.fairladyZRZ34_2023))
}
