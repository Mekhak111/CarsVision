//
//  AutoSalon.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/25/24.
//

import SwiftUI
import RealityKit

struct AutoSalon: View {
  
  @State var autoSalon: ModelEntity = ModelEntity()
  @State var carOrder: Int = 0
  @State var salonModels = NissanModel.salonModels
  
  var body: some View {
    RealityView { content in
      if let autoSalon = try? await ModelEntity(named: "Salon3") {
        self.autoSalon = autoSalon
      }
      autoSalon.position = [0,0,-8]
      content.add(autoSalon)
    }
    .task {
      await getCars()
    }
  }
}

extension AutoSalon {
  
  func getCars() async {
    let positions = generateCarPositions()
    for model in salonModels {
      if let auto = try? await ModelEntity(named: model.modelName) {
        auto.position = positions[carOrder]
        carOrder += 1
        let sizes = getSizes(carEnt: auto)
        let scale = calculateScale(for: sizes)
        auto.scale = [Float(scale), Float(scale), Float(scale)]
        autoSalon.addChild(auto)
      }
    }
  }
  
  func getSizes(carEnt: ModelEntity) -> [Double] {
    let width =
    (carEnt.model?.mesh.bounds.max.x)! - (carEnt.model?.mesh.bounds.min.x)!
    let height =
    (carEnt.model?.mesh.bounds.max.y)! - (carEnt.model?.mesh.bounds.min.y)!
    let depth =
    (carEnt.model?.mesh.bounds.max.z)! - (carEnt.model?.mesh.bounds.min.z)!
    let carSize: [Double] = [Double(width), Double(height), Double(depth)]
    return carSize
  }
  
  func calculateScale(for array: [Double]) -> Double {
    guard let maxElement = array.max(), maxElement > 0 else {
      fatalError("Array must not be empty and should contain positive values.")
    }
    let scaleFactor = 4.0 / maxElement
    return scaleFactor
  }
  
  func generateCarPositions() -> [SIMD3<Float>]{
    let initialPosition: SIMD3<Float> = [-8,0.3,-5]
    var result: [SIMD3<Float>] = []
    result.append(initialPosition)
    for _ in 0...1 {
      var temp = result.last!
      temp[0] += 8
      result.append(temp)
    }
    
    let secondInitial: SIMD3<Float> = [-8,0.3,0]
    result.append(secondInitial)
    for _ in 0...1 {
      var temp = result.last!
      temp[0] += 8
      result.append(temp)
    }
    
    let thirdInitial: SIMD3<Float> = [-8,0.3,5]
    result.append(thirdInitial)
    for _ in 0...1 {
      var temp = result.last!
      temp[0] += 8
      result.append(temp)
    }
    
    return result
  }
  
  func deg2rad(_ number: Double) -> Double {
    return number * .pi / 180
  }
  
}

#Preview {
  AutoSalon()
}


