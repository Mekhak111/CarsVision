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
            viewModel.carEnt.model?.materials[i] = SimpleMaterial(color: SimpleMaterial.Color(newValue), isMetallic: false)
          }
        }
      }
      .onChange(of: appModel.selectedTexture) { oldValue, newValue in
        Task {
          for i in 0..<(viewModel.carEnt.model?.materials.count ?? 0) {
            if viewModel.copies[i] == appModel.selectedMaterial {
              viewModel.carEnt.model?.materials[i] = await UnlitMaterial(texture: try TextureResource(named: newValue))
            }
          }
        }
      }
  }
  
}

extension Car3DView {

  private var car3DContent: some View {
    RealityView { content, attachments in
      if let car = try? await ModelEntity(named: appModel.carModel.modelName)
      {
        let carAnchor = AnchorEntity(world: [0, -1, -5])
        
        if let pickkerAttachment = attachments.entity(for: "ColorPicker") {
          pickkerAttachment.position = [2, 3, 0]
          pickkerAttachment.scale = [10,10,10]
          carAnchor.addChild(pickkerAttachment)
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
      VStack {
        if !viewModel.isWheelsOpens && !viewModel.isPickerOpened {
          Button{
            if viewModel.isPickerOpened {
              dismissWindow.callAsFunction(id: "Picker")
            } else {
              openWindow.callAsFunction(id: "Picker")
            }
            viewModel.isPickerOpened.toggle()
          } label: {
            Text(viewModel.isPickerOpened ? "Close Picker" : "Open Picker")
              .font(.title)
              .frame(width: 200)
          }
          
          Button {
            if viewModel.isWheelsOpens {
              dismissWindow.callAsFunction(id: "Wheels")
            } else {
              openWindow.callAsFunction(id: "Wheels")
            }
            viewModel.isWheelsOpens.toggle()
          } label: {
            Text("Choose Wheels")
              .font(.title)
              .frame(width: 200)
          }
          
        } else {
          Button {
            if viewModel.isWheelsOpens {
              dismissWindow.callAsFunction(id: "Wheels")
              viewModel.isWheelsOpens.toggle()
            } else {
              dismissWindow.callAsFunction(id: "Picker")
              viewModel.isPickerOpened.toggle()
            }
          } label: {
            Text("Close Whindows")
              .font(.title)
              .frame(width: 200)
          }
          
        }
      }
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
  
}
