//
//  CarDetailsScreen.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/14/24.
//

import SwiftUI

struct CarDetailsScreen: View {

  @State private var isShowModel: Bool = false
  @State private var isShowImmersive: Bool = false

  @Environment(\.openWindow) private var openWindow
  @Environment(\.dismissWindow) private var dismissWindow
  @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
  @Environment(\.openImmersiveSpace) private var openImmersiveSpace
  @Environment(\.appModel) private var appModel

  var carModel: NissanModel

  var body: some View {
    HStack {
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
        HStack {
          Button {
            isShowModel.toggle()
            appModel.carModel = carModel
            showWindow()
          } label: {
            Text(isShowModel ? "Dismiss 3D Model" : "Show 3D Model")
          }
          
          Button {
            isShowImmersive.toggle()
            appModel.carModel = carModel
            showImmersiveSpace()
          } label: {
            Text(isShowImmersive ? "Dismiss Imersive" : "Show Imersive")
          }

          
        }
      }
      Image("nissan.gtr")
        .resizable()
        .scaledToFit()
    }
    .padding()
  }

  private func showWindow() {
    if isShowModel {
      openWindow(id: "Car")
    } else {
      dismissWindow(id: "Car")
    }
  }

  private func showImmersiveSpace() {
    if isShowImmersive {
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
  CarDetailsScreen(carModel: .kicks2019)
}
