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
  
  @State private var copies:[String] = []
  
  @State var carEnt:ModelEntity? = nil
  
  var body: some View {
    GeometryReader3D { geometry in
      RealityView { content, attachments in
        if let car = try? await ModelEntity(named: appModel.carModel.modelName)
        {
          let bounds = content.convert(
            geometry.frame(in: .local),
            from: .local,
            to: content
          )
          let minExtent = bounds.extents.min()
          car.scale = [minExtent * 0.01, minExtent * 0.01, minExtent * 0.01]
          
          
          let carAnchor = AnchorEntity(world: [0, -1, -2])
          if let pickkerAttachment = attachments.entity(for: "ColorPicker") {
            pickkerAttachment.position = [1, 0, 0]
            carAnchor.addChild(pickkerAttachment)
          }
          carEnt = car
          carAnchor.addChild(carEnt ?? car)
          
          content.add(carAnchor)
          
          car.model?.materials.forEach {
            appModel.materials.append($0.name ?? "")
            copies.append($0.name ?? "")
          }
          
          
        }
      } attachments: {
        Attachment(id: "ColorPicker") {
          Button{
            openWindow.callAsFunction(id: "Picker")
          } label: {
            Text("Choose material to change color")
              .font(.title)
              .frame(width: 200)
          }
        }
      }
      .onDisappear {
        appModel.selectedColor = .clear
        appModel.selectedMaterial = ""
        appModel.materials.removeAll()
      }
      .onChange(of: appModel.selectedColor) { oldValue, newValue in
        for i in 0..<(carEnt?.model?.materials.count ?? 0) {
          if copies[i] == appModel.selectedMaterial {
            carEnt?.model?.materials[i] = SimpleMaterial(color: SimpleMaterial.Color(newValue), isMetallic: false)
          }
        }
      }
    }
  }
  
}

struct CarModelInVolumetric: View {
  
  @Environment(\.appModel) private var appModel
  
  var body: some View {
    Model3D(named: appModel.carModel.modelName) { car in
      car
        .resizable()
    } placeholder: {
      ProgressView()
        .progressViewStyle(.circular)
    }
  }
  
}



