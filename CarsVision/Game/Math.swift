//
//  Math.swift
//  CarsVision
//
//  Created by Narek Aslanyan on 27.11.24.
//

import Foundation
import RealityKit

struct Math {

  // MARK: - Angle, rotation & distance

  static func rotateX(_ x: Float) -> simd_quatf {
    let xx = Math.degreesToRadians(x)

    let rotationQuaternionX = simd_quatf(angle: xx, axis: SIMD3<Float>(1, 0, 0))
    return rotationQuaternionX
  }

  static func rotateY(_ y: Float) -> simd_quatf {
    let yy = Math.degreesToRadians(y)

    let rotationQuaternionY = simd_quatf(angle: yy, axis: SIMD3<Float>(0, 1, 0))
    return rotationQuaternionY
  }

  static func rotateZ(_ z: Float) -> simd_quatf {
    let zz = Math.degreesToRadians(z)

    let rotationQuaternionZ = simd_quatf(angle: zz, axis: SIMD3<Float>(0, 0, 1))
    return rotationQuaternionZ
  }

  static func rotate(x: Float, y: Float, z: Float) -> simd_quatf {
    let xx = Math.degreesToRadians(x)
    let yy = Math.degreesToRadians(y)
    let zz = Math.degreesToRadians(z)

    let rotationQuaternionX = simd_quatf(angle: xx, axis: SIMD3<Float>(1, 0, 0))
    let rotationQuaternionY = simd_quatf(angle: yy, axis: SIMD3<Float>(0, 1, 0))
    let rotationQuaternionZ = simd_quatf(angle: zz, axis: SIMD3<Float>(0, 0, 1))
    let rotation = rotationQuaternionX * rotationQuaternionY * rotationQuaternionZ

    return rotation
  }

  static func angleBetweenPoints(x1: Float, y1: Float, x2: Float, y2: Float) -> Float {
    let xDiff = x2 - x1
    let yDiff = y2 - y1

    return atan2(yDiff, xDiff) * 180.0 / Float.pi
  }

  static func distance(x1: Float, y1: Float, x2: Float, y2: Float) -> Float {
    hypotf((x1 - x2), (y1 - y2))
  }

  // MARK: - RAD/DEG

  static func degreesToRadians(_ value: Float) -> Float {
    value * Float.pi / 180.0
  }

  static func radiansToegrees(_ value: Float) -> Float {
    value * 180.0 / Float.pi
  }

  // MARK: - Random functions

  static func random(min: Int, max: Int) -> Int {
    min + Int(arc4random_uniform(UInt32(max - min + 1)))
  }

  static func random01f() -> Float {
    let rnd = Float(Math.random(min: 0, max: 10))
    return rnd * 0.1
  }

  static func randomTrueFalse() -> Bool {
    let rnd = Math.random(min: 0, max: 1)
    if rnd == 1 {
      return true
    }
    return false
  }

  static func randomPlusMinus() -> Float {
    let rnd = Math.random(min: 0, max: 1)
    if rnd == 1 {
      return 1.0
    }
    return -1.0
  }
}
