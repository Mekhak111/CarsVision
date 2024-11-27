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
    HStack(spacing: 40) {
      carInfoView
      rightSideView
    }
    .navigationBarBackButtonHidden(viewModel.isShowImmersive)
    .padding()
  }
  
  private var carInfoView: some View {
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
    }
  }
  
  private var rightSideView: some View {
    VStack(alignment: .leading, spacing: 0) {
      Spacer()

      VStack(alignment: .leading, spacing: 20) {
        showDismissModelButton
        showDismissImmersiveButton
      }
      
      Image(.nissan)
        .resizable()
        .renderingMode(.template)
        .scaledToFit()
        .foregroundStyle(.white)
        .frame(width: 300, height: 300)
        .background(.thinMaterial)
        .clipShape(Circle())
        .padding(.top, 20)

      Spacer()
    }
  }

  private var showDismissModelButton: some View {
    HoverButtonView(
      primaryText: viewModel.isShowModel ? "Dismiss 3D Model" : "Show 3D Model",
      secondaryText: "",
      iconName: "car.fill"
    ) {
      viewModel.isShowModel.toggle()
      appModel.carModel = viewModel.carModel
      showWindow()
    }
  }

  private var showDismissImmersiveButton: some View {
    HoverButtonView(
      primaryText: viewModel.isShowImmersive ? "Dismiss Immersive" : "Show Immersive",
      secondaryText: "",
      iconName: "figure.2.circle"
    ) {
      viewModel.isShowImmersive.toggle()
      appModel.carModel = viewModel.carModel
      showImmersiveSpace()
    }
  }

  private func showWindow() {
    if viewModel.isShowModel {
      openOptionWindow(.car)
    } else {
      closeOptionWindow(.car)
    }
  }

  func openOptionWindow(_ window: Window) {
    CarsVisionApp.openWindowIfCan(by: window) {
      Task { @MainActor in
        openWindow(id: window.rawValue)
      }
    }
  }

  func closeOptionWindow(_ window: Window) {
    CarsVisionApp.closeWindow(by: window) {
      Task { @MainActor in
        dismissWindow(id: window.rawValue)
      }
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
