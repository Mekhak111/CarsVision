//
//  AppModel.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/14/24.
//

import SwiftUI

/// Maintains app-wide state
@MainActor
@Observable
class AppModel {
  
  enum ImmersiveSpaceState {
    case closed
    case inTransition
    case open
  }

  var carModel: NissanModel = .z350
  var immersiveSpaceState = ImmersiveSpaceState.closed
  let immersiveSpaceID = "ImmersiveSpace"
  var materials: [String] = []
  var selectedMaterial: String = "Car"
  var selectedColor: Color = .red
  
}
