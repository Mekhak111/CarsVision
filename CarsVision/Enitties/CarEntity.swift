//
//  CarEntity.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/20/24.
//

import Foundation
import RealityKit

class CarEntity: Entity {

  private var car: Entity = Entity()
  private let equatorialPlane = Entity()
  private let rotator = Entity()

  @MainActor required init() {
    super.init()
  }

  init(cartype: NissanModel, configuration: Configuration) async {
    super.init()
    guard let carr = try? await Entity(named: cartype.modelName) else { return }
    self.car = carr
    self.addChild(equatorialPlane)
    equatorialPlane.addChild(rotator)
    rotator.addChild(car)

    update(configuration: configuration)
    //    move(
    //        to: Transform(
    //            scale: SIMD3(repeating: configuration.scale),
    //            rotation: orientation,
    //            translation: configuration.position),
    //        relativeTo: parent
    //    )

  }

  func update(configuration: Configuration) {
    rotator.orientation = configuration.rotation
    car.components.set(RotationComponent(speed: configuration.currentSpeed))
  }

}

extension CarEntity {

  struct Configuration {

    var scale: Float = 0.6
    var rotation: simd_quatf = .init(angle: 0, axis: [0, 1, 0])
    var speed: Float = 0
    var isPaused: Bool = false
    var position: SIMD3<Float> = .zero

    var currentSpeed: Float {
      isPaused ? 0 : speed
    }

  }

}

struct RotationComponent: Component {

  var speed: Float
  var axis: SIMD3<Float>

  init(speed: Float = 1.0, axis: SIMD3<Float> = [0, 1, 0]) {
    self.speed = speed
    self.axis = axis
  }

}
