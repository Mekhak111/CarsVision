//
//  Car3DViewModel.swift
//  CarsVision
//
//  Created by Narek Aslanyan on 22.11.24.
//

import SwiftUI
import RealityFoundation

@Observable
class Car3DViewModel {
  
  var copies: [String] = []
  var carEnt: ModelEntity = ModelEntity()
  var rotationA: Angle = .zero
  var transformMatrix: Transform = Transform()
  var isPickerOpened: Bool = false
  var isWheelsOpens: Bool = false
  
  func getSizes() -> [Double] {
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
    let scaleFactor = 5.0 / maxElement
    return scaleFactor
  }
  
}
