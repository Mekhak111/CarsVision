//
//  TexturesView.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/25/24.
//

import SwiftUI

struct TexturesView: View {
  
  @Environment(\.appModel) private var appModel
  
  let imageNames = [
    "texture1", "texture2", "texture3", "texture4",
    "texture5", "texture24", "texture6", "texture7",
    "texture8", "texture9", "texture10", "texture11",
    "texture12", "texture13", "texture14", "texture15",
    "texture16", "texture17", "texture18", "texture19",
    "texture20", "texture21", "texture22", "texture23",
    "texture25"
  ]
  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  
  
  @State private var selectedImage: String? = nil
  

  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: 16) {
        ForEach(imageNames, id: \.self) { imageName in
          Button {
            selectedImage = imageName
            appModel.selectedTexture = imageName
          } label: {

              Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .frame(width: 200)

          }
          .frame(height: 200)
          .frame(width: 200)
          .clipShape(RoundedRectangle(cornerRadius: 8))
          .overlay(
            RoundedRectangle(cornerRadius: 8)
              .stroke(selectedImage == imageName ? Color.blue : Color.clear, lineWidth: 4)
          )
          
        }
      }
      .padding()
    }
  }
}
