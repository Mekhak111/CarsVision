//
//  PickerMaterial.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/21/24.
//

import SwiftUI

struct PickerMaterial: View {

  @Environment(\.appModel) private var appModel
  @Environment(\.openWindow) private var openWindow

  @State var selectedMaterial: String = "Part Picker"
  @State var partColor: Color = .white

  var body: some View {
    VStack {
      Text("Choose Part")
        .font(.title)
      Picker("Please choose a Part", selection: $selectedMaterial) {
        ForEach(appModel.materials, id: \.self) {
          Text($0)
        }
      }
      .padding(.bottom, 50)
      ColorPicker("Choose Color", selection: $partColor)
        .padding(.horizontal, 50)
      Button {
        openWindow.callAsFunction(id: "Textures")
      } label: {
        Text("Add Texture")
      }
      .padding()

    }
    .onChange(of: selectedMaterial) { _, material in
      appModel.selectedMaterial = material
    }
    .onChange(of: partColor) { _, color in
      appModel.selectedColor = color
    }
  }

}
