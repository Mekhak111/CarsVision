//
//  HoverButtonView.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/26/24.
//

import SwiftUI

struct HoverButtonView: View {

  var primaryText: String
  var secondaryText: String
  var iconName: String
  var action: () -> Void = {}

  var body: some View {
    Button(action: action) {
      HStack(spacing: 2) {
        HoverIconView(iconName: iconName)
        HoverDetailView(primaryText: primaryText, secondaryText: secondaryText)
          .hoverEffect(FadeEffect())
      }
    }
    .buttonStyle(HoverButtonStyle())
    .hoverEffectGroup()
  }

}
struct HoverButtonStyle: ButtonStyle {

  @Environment(\.accessibilityReduceMotion) var reduceMotion

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background {
        ZStack(alignment: .leading) {
          Capsule()
            .fill(.thinMaterial)
            .hoverEffect(.highlight)
            .hoverEffect(reduceMotion ? HoverEffect(FadeEffect()) : HoverEffect(.empty))
          if reduceMotion {
            Circle()
              .fill(.thinMaterial)
              .hoverEffect(.highlight)
              .hoverEffect(FadeEffect(from: 1, to: 0))
          }
        }
      }
      .hoverEffect(reduceMotion ? HoverEffect(.empty) : HoverEffect(ExpandEffect()))
  }
}

struct ExpandEffect: CustomHoverEffect {

  func body(content: Content) -> some CustomHoverEffect {
    content.hoverEffect { effect, isActive, proxy in
      effect.animation(.default.delay(isActive ? 0.8 : 0.2)) {
        $0.clipShape(
          .capsule.size(
            width: isActive ? proxy.size.width : proxy.size.height,
            height: proxy.size.height,
            anchor: .leading
          ))
      }
      .scaleEffect(isActive ? 1.05 : 1.0)
    }
  }

}

struct FadeEffect: CustomHoverEffect {

  var from: Double = 0
  var to: Double = 1

  func body(content: Content) -> some CustomHoverEffect {
    content.hoverEffect { effect, isActive, _ in
      effect.animation(.default.delay(isActive ? 0.8 : 0.2)) {
        $0.opacity(isActive ? to : from)
      }
    }
  }
}

struct HoverIconView: View {

  var iconName: String

  var body: some View {
    Image(systemName: iconName)
      .resizable()
      .scaledToFit()
      .frame(
        width: 44,
        height: 44
      )
      .padding(6)
  }
}

struct HoverDetailView: View {

  var primaryText: String
  var secondaryText: String

  var body: some View {
    VStack(alignment: .leading) {
      Text(primaryText)
        .font(.body)
        .foregroundStyle(.primary)
      Text(secondaryText)
        .font(.footnote)
        .foregroundStyle(.tertiary)
    }
    .padding(.trailing, 24)
  }
}

#Preview {
  HoverButtonView(
    primaryText: "Primary Text",
    secondaryText: "Seconday Text",
    iconName: "checkmark.circle"
  )
}
