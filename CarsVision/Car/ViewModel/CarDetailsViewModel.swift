//
//  CarDetailsViewModel.swift
//  CarsVision
//
//  Created by Narek Aslanyan on 22.11.24.
//

import Foundation

@Observable
class CarDetailsViewModel {
  
  var isShowModel: Bool = false
  var isShowImmersive: Bool = false
  let carModel: NissanModel
  
  init(carModel: NissanModel) {
    self.carModel = carModel
  }
  
}
