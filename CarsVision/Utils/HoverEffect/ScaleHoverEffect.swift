//
//  ScaleHoverEffect.swift
//  CarsVision
//
//  Created by Narek Aslanyan on 27.11.24.
//

import SwiftUI

@available(visionOS 2.0, *)
struct ScaleHoverEffect: CustomHoverEffect {

  func body(content: Content) -> some CustomHoverEffect {
    content.hoverEffect { effect, isActive, proxy in
      effect.animation(.easeOut) {
        $0.scaleEffect(isActive ? 1.2 : 1, anchor: .top)
      }
    }
  }

}

struct ScaleHoverButtonStyle: ButtonStyle {

  var isSelected: Bool = false

  func makeBody(configuration: Configuration) -> some View {
    if #available(visionOS 2.0, *) {
      configuration.label
        .padding()
        .background(.thinMaterial)
        .background(isSelected ? Color.white.opacity(0.7) : Color.gray.opacity(0.3))
        .font(.headline)
        .cornerRadius(12)
        .hoverEffect(ScaleHoverEffect())
    } else {
      configuration.label
        .padding()
        .background(.thinMaterial)
        .background(isSelected ? Color.white.opacity(0.7) : Color.gray.opacity(0.3))
        .font(.headline)
        .cornerRadius(12)
        .opacity(configuration.isPressed ? 0.9 : 1)
        .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
  }

}
