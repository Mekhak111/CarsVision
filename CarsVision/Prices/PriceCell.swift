//
//  PriceCell.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/26/24.
//

import SwiftUI

struct PriceCell: View {
  
  let model: NissanModel
  let isSelected: Bool
  
  var body: some View {
    VStack(spacing: 8) {
      Text(model.name)
        .font(.headline)
        .multilineTextAlignment(.center)
        .foregroundColor(.primary)
      
      Text("$\(model.price, specifier: "%.2f")")
        .font(.subheadline)
        .foregroundColor(.secondary)
    }
    .padding()
    .frame(maxWidth: .infinity)
    .frame(height: isSelected ? 150 : 100)
    .opacity(0.9)
    .cornerRadius(10)
    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    .scaleEffect(isSelected ? 1.05 : 1.0)
  }
  
}

#Preview {
  PriceCell(
    model: .fairladyZRZ34_2023,
    isSelected: false
  )
}
