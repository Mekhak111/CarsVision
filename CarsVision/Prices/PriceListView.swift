//
//  PriceListView.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/26/24.
//

import SwiftUI

struct PriceListView: View {
  
  @Environment(\.appModel) private var appModel
  @State private var selectedModel: NissanModel? = nil

  let models = NissanModel.allCases
  let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]  
  
  var body: some View {
    ZStack {
      ScrollView {
        LazyVGrid(columns: columns, spacing: 16) {
          ForEach(models, id: \.self) { model in
            Button {
              withAnimation(.spring()) {
                if selectedModel == model {
                  selectedModel = nil
                } else {
                  selectedModel = model
                }
              }
            } label: {
              PriceCell(model: model, isSelected: selectedModel == model)
            }
              
          }
        }
        .padding()
      }
    }
    .onChange(of: appModel.carModel) { oldValue, newValue in
      selectedModel = newValue
    }
  }
  
}
