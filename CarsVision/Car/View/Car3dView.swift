//
//  Car3DView.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/15/24.
//

import RealityKit
import SwiftUI

struct Car3DView: View {

  @Environment(\.appModel) private var appModel
  @Environment(\.openWindow) private var openWindow
  @Environment(\.dismissWindow) private var dismissWindow
  @State private var viewModel = Car3DViewModel()

  var body: some View {
    car3DContent
      .gesture(dragGesture)
      .onDisappear {
        appModel.selectedColor = .clear
        appModel.selectedMaterial = ""
        appModel.materials.removeAll()
      }
      .onChange(of: appModel.selectedColor) { oldValue, newValue in
        for i in 0..<(viewModel.carEnt.model?.materials.count ?? 0) {
          if viewModel.copies[i] == appModel.selectedMaterial {
            viewModel.carEnt.model?.materials[i] = SimpleMaterial(
              color: SimpleMaterial.Color(newValue), isMetallic: false)
          }
        }
      }
      .onChange(of: appModel.selectedTexture) { oldValue, newValue in
        Task {
          for i in 0..<(viewModel.carEnt.model?.materials.count ?? 0) {
            if viewModel.copies[i] == appModel.selectedMaterial {
              viewModel.carEnt.model?.materials[i] = await UnlitMaterial(
                texture: try TextureResource(named: newValue))
            }
          }
        }
      }
  }

}

extension Car3DView {

  private var car3DContent: some View {
    RealityView { content, attachments in
      if let car = try? await ModelEntity(named: appModel.carModel.modelName) {
        let carAnchor = AnchorEntity(world: [0, -1, -5])

        if let pickerAttachment = attachments.entity(for: "ColorPicker") {
          pickerAttachment.position = [2, 1, 0]
          pickerAttachment.scale = [10, 10, 10]
          carAnchor.addChild(pickerAttachment)
        }

        viewModel.carEnt = car
        let sizes = viewModel.getSizes()
        let scale = viewModel.calculateScale(for: sizes)
        viewModel.carEnt.scale = [Float(scale), Float(scale), Float(scale)]
        viewModel.transformMatrix = viewModel.carEnt.transform
        carAnchor.addChild(viewModel.carEnt)
        car.model?.materials.forEach {
          appModel.materials.append($0.name ?? "")
          viewModel.copies.append($0.name ?? "")
        }
        content.add(carAnchor)
      }
    } update: { content, attachments in
      viewModel.carEnt.components.set(InputTargetComponent())
      viewModel.carEnt.generateCollisionShapes(recursive: false)
    } attachments: {
      attachment
    }
  }

  private var attachment: Attachment<some View> {
    Attachment(id: "ColorPicker") {
      VStack(spacing: 8) {
        pickerButton
        wheelsButton
        openMainButton
        if viewModel.hasOpenedWindows {
          closeWindowsButton
        }
      }
    }
  }

  private var pickerButton: some View {
    Button {
      if viewModel.isPickerOpened {
        closeOptionWindow(Window.picker)
      } else {
        openOptionWindow(Window.picker)
      }
      viewModel.isPickerOpened.toggle()
    } label: {
      Text(viewModel.isPickerOpened ? "Close Picker" : "Open Picker")
        .font(.title)
    }
  }

  private var wheelsButton: some View {
    Button {
      if viewModel.isWheelsOpened {
        closeOptionWindow(Window.wheels)
      } else {
        openOptionWindow(Window.wheels)
      }
      viewModel.isWheelsOpened.toggle()
    } label: {
      Text(viewModel.isWheelsOpened ? "Close Wheels" : "Choose Wheels")
        .font(.title)
    }
  }

  private var openMainButton: some View {
    Button {
      if viewModel.isGameOpened {
        closeOptionWindow(Window.game)
      } else {
        openOptionWindow(Window.game)
      }
      viewModel.isGameOpened.toggle()
    } label: {
      Text(viewModel.isGameOpened ? "Close Game" : "Open Game")
        .font(.title)
    }
  }

  private var closeWindowsButton: some View {
    Button {
      closeOptionWindow(Window.wheels)
      closeOptionWindow(Window.picker)
      closeOptionWindow(Window.game)
      closeOptionWindow(Window.textures)
      viewModel.isPickerOpened = false
      viewModel.isGameOpened = false
      viewModel.isWheelsOpened = false
    } label: {
      Text("Close Windows")
        .font(.title)
    }
  }

  private var dragGesture: some Gesture {
    DragGesture()
      .targetedToEntity(viewModel.carEnt)
      .onChanged { change in
        print("rotate")
        print(change.translation)
        viewModel.rotationA.degrees += change.translation.width > 0 ? 3 : -3
        var m1 = Transform(yaw: Float(viewModel.rotationA.radians))
        m1.scale = viewModel.transformMatrix.scale
        viewModel.carEnt.transform.matrix = m1.matrix
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

}

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

struct ImageCollectionButtonStyle: ButtonStyle {

  var isSelected: Bool = false

  func makeBody(configuration: Configuration) -> some View {
    if #available(visionOS 2.0, *) {
      configuration.label
        .padding()
        .background(isSelected ? Color.white.opacity(0.7) : Color.gray.opacity(0.3))
        .font(.headline)
        .cornerRadius(12)
        .hoverEffect(ScaleHoverEffect())
    } else {
      configuration.label
        .padding()
        .background(isSelected ? Color.white.opacity(0.7) : Color.gray.opacity(0.3))
        .font(.headline)
        .cornerRadius(12)
        .opacity(configuration.isPressed ? 0.9 : 1)
        .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
  }

}
