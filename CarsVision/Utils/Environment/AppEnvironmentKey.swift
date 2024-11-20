//
//  AppEnvironmentKey.swift
//  CarsVision
//
//  Created by Narek Aslanyan on 18.11.24.
//

import SwiftUI

private struct AppModelKey: EnvironmentKey {

  typealias Value = AppModel

  @MainActor static var defaultValue: AppModel = AppModel()

}

extension EnvironmentValues {

  var appModel: AppModel {
    get { self[AppModelKey.self] }
    set { self[AppModelKey.self] = newValue }
  }

}
