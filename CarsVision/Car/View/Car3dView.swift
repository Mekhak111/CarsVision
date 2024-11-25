//
//  Car3dView.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/15/24.
//

import RealityKit
import SwiftUI

struct CarModel: View {
  
  @Environment(\.appModel) private var appModel
  @Environment(\.openWindow) private var openWindow
  @Environment(\.dismissWindow) private var dismissWindow
  
  @State var carEnt:ModelEntity = ModelEntity()
  @State var rotationA: Angle = .zero
  @State var transformMatrix: Transform = Transform()
  @State var isPickerOPened: Bool = false
  @State var isWheelsOpens: Bool = false
  
  @State private var copies:[String] = []
  
  var body: some View {
    RealityView { content, attachments in
      if let car = try? await ModelEntity(named: appModel.carModel.modelName)
      {
        let carAnchor = AnchorEntity(world: [0, -1, -5])
        
        if let pickkerAttachment = attachments.entity(for: "ColorPicker") {
          pickkerAttachment.position = [2, 1, 0]
          pickkerAttachment.scale = [10,10,10]
          carAnchor.addChild(pickkerAttachment)
        }
        
        carEnt = car
        let sizes = getSizes()
        let scale = calculateScale(for: sizes)
        carEnt.scale = [Float(scale), Float(scale), Float(scale)]
        transformMatrix = carEnt.transform
        carAnchor.addChild(carEnt)
        car.model?.materials.forEach {
          
          appModel.materials.append($0.name ?? "")
          copies.append($0.name ?? "")
        }
        content.add(carAnchor)
        
      }
    } update: { content, attachments in
      carEnt.components.set(InputTargetComponent())
      carEnt.generateCollisionShapes(recursive: false)
    } attachments: {
      attachment
    }
    .gesture(dragGesture)
    .onDisappear {
      appModel.selectedColor = .clear
      appModel.selectedMaterial = ""
      appModel.materials.removeAll()
    }
    .onChange(of: appModel.selectedColor) { oldValue, newValue in
      for i in 0..<(carEnt.model?.materials.count ?? 0) {
        if copies[i] == appModel.selectedMaterial {
          carEnt.model?.materials[i] = SimpleMaterial(color: SimpleMaterial.Color(newValue), isMetallic: false)
        }
      }
    }
  }
  
}

extension CarModel {
  
  private var attachment: Attachment<some View> {
    Attachment(id: "ColorPicker") {
      VStack {
        if !isWheelsOpens && !isPickerOPened {
          Button{
            if isPickerOPened {
              dismissWindow.callAsFunction(id: "Picker")
            } else {
              openWindow.callAsFunction(id: "Picker")
            }
            isPickerOPened.toggle()
          } label: {
            Text(isPickerOPened ? "Close Picker" : "Open Picker")
              .font(.title)
              .frame(width: 200)
          }
          
          Button {
            if isWheelsOpens {
              dismissWindow.callAsFunction(id: "Wheels")
            } else {
              openWindow.callAsFunction(id: "Wheels")
            }
            isWheelsOpens.toggle()
          } label: {
            Text("Choose Wheels")
              .font(.title)
              .frame(width: 200)
          }
          
        } else {
          Button {
            if isWheelsOpens {
              dismissWindow.callAsFunction(id: "Wheels")
              isWheelsOpens.toggle()
            } else {
              dismissWindow.callAsFunction(id: "Picker")
              isPickerOPened.toggle()
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
      .targetedToEntity(carEnt)
      .onChanged { change in
        rotationA.degrees += change.translation.width > 0 ? 3 : -3
        var m1 = Transform(yaw: Float(rotationA.radians))
        m1.scale = transformMatrix.scale
        carEnt.transform.matrix = m1.matrix
      }
  }
  
  private func getSizes() -> [Double] {
    let width = (carEnt.model?.mesh.bounds.max.x)! - (carEnt.model?.mesh.bounds.min.x)!
    let height = (carEnt.model?.mesh.bounds.max.y)! - (carEnt.model?.mesh.bounds.min.y)!
    let depth = (carEnt.model?.mesh.bounds.max.z)! - (carEnt.model?.mesh.bounds.min.z)!
    let carSize: [Double] = [ Double(width) , Double(height), Double(depth)]
    return carSize
  }
  
  private func calculateScale(for array: [Double]) -> Double {
    guard let maxElement = array.max(), maxElement > 0 else {
      fatalError("Array must not be empty and should contain positive values.")
    }
    let scaleFactor = 5.0 / maxElement
    return scaleFactor
  }
  
}
