//
//  GameObject.swift
//  CarsVision
//
//  Created by Narek Aslanyan on 27.11.24.
//

import Foundation
import RealityKit

class GameObject {

  static let defaultVelocity: Float = 100

  private static var counter = 0
  private var uniqueID = 0
  private var _tag = 0
  private var _entity: Entity?
  private var _scale: Float = 1.0
  private var _position = SIMD3<Float>(0, 0, 0)
  private var _rotation = SIMD3<Float>(0, 0, 0)
  private var _velocity: Float = 0
  private var _angle: Float = 0
  private var _isActive = true

  var id: Int {
    return uniqueID
  }

  var tag: Int {
    get {
      return _tag
    }
    set(value) {
      _tag = value
    }
  }

  var isActive: Bool {
    get {
      return _isActive
    }
    set(value) {
      _isActive = value
      _entity?.isEnabled = _isActive
    }
  }

  var velocity: Float {
    get {
      return _velocity
    }
    set(value) {
      _velocity = value
    }
  }

  var angle: Float {
    get {
      return _angle
    }
    set(value) {
      _angle = value
    }
  }

  var position: SIMD3<Float> {
    get {
      return _position
    }
    set(value) {
      _position = value
      if _entity != nil {
        _entity?.position = _position
      }
    }
  }

  private var rotation: SIMD3<Float> {
    get {
      return _rotation
    }
    set(value) {
      _rotation = value

      if _entity != nil {
        // Node works with DEG, SceneKit with RAD
        let x = Math.degreesToRadians(_rotation.x)
        let y = Math.degreesToRadians(_rotation.y)
        let z = Math.degreesToRadians(_rotation.z)

        let rotationQuaternionX = simd_quatf(
          angle: x, axis: SIMD3<Float>(1, 0, 0))
        let rotationQuaternionY = simd_quatf(
          angle: y, axis: SIMD3<Float>(0, 1, 0))
        let rotationQuaternionZ = simd_quatf(
          angle: z, axis: SIMD3<Float>(0, 0, 1))

        _entity?.transform.rotation =
          rotationQuaternionX * rotationQuaternionY * rotationQuaternionZ
      }
    }
  }

  var scale: Float {
    get {
      return _scale
    }
    set(value) {
      _scale = value
      if _entity != nil {
        _entity?.transform.scale = [_scale, _scale, _scale]
      }
    }
  }

  var entity: Entity? {
    get {
      return _entity
    }
    set(value) {
      _entity = value
    }
  }

  public func changeDirection(to angle: Float) {
    _angle = angle
  }

  public func changeDirection(by angle: Float) {
    _angle += angle
  }

  public func removeFromScene() {
    _entity?.removeFromParent()
    _entity = nil
    print("Game object '\(self.id)' removed from scene")
  }

  public func reset() {
    self.isActive = true
  }

  internal func update(deltaTime: Float) {
    let speedX = _velocity * deltaTime
    let speedY = _velocity * deltaTime
    let dx = cos(Math.degreesToRadians(_angle))
    let dy = sin(Math.degreesToRadians(_angle))
    self.position.x += speedX * dx
    self.position.z += speedY * dy
    var rotation = self.rotation
    rotation.y = -1.0 * (_angle - 90.0)
    self.rotation = rotation
  }

  func move() {
    self.velocity = GameObject.defaultVelocity
  }

  init() {
    GameObject.counter += 1
    uniqueID = GameObject.counter
    self.rotation = [0, 90, 0]
  }

  init(entity: Entity) {
    GameObject.counter += 1
    uniqueID = GameObject.counter
    self.rotation = [0, 90, 0]
    _entity = entity
  }

}
