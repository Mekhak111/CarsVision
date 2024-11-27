//
//  GameController.swift
//  CarsVision
//
//  Created by Narek Aslanyan on 27.11.24.
//

import Foundation

enum GameState {

  case start  // Intro Dialog (2D)
  case placeCar  // Place car (3D)
  case placed  // All placed, ready to play (3D)
  case play  // Game
  case end  // Game ends (Can play again)

}

typealias GameStateCallBack = (GameState, GameState) -> Void

class GameController {
  private static var instance: GameController? = nil

  private var gameState = GameState.start

  var onStateChanged: GameStateCallBack?
  var carObject: GameObject? = nil

  static var shared: GameController {
    if GameController.instance == nil {
      GameController.instance = GameController()
    }
    return GameController.instance!
  }

  func changeState(to newValue: GameState) {
    let oldState = gameState
    gameState = newValue
    if newValue == .play {
      start()
    }
    print("Change game state from '\(oldState)' to '\(newValue)'")
    onStateChanged?(oldState, gameState)
  }

  private func update(deltaTime: Float) -> Bool {
    if gameState != .play {
      print("Stop game. Game state is '\(gameState)'")
      return false
    }

    carObject?.update(deltaTime: deltaTime)
    return true
  }

  private func start() {
    guard let car = self.carObject else { return }
    print("Start game")
    car.move()
    let interval: TimeInterval = 1.0 / 60 // 60 FPS, call every 16.666 ms
    Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
      if !self.update(deltaTime: Float(interval)) {
        timer.invalidate()
        return
      }
    }
  }

  func setCarPosition(_ pos: SIMD3<Float>) {
    guard let car = self.carObject else { return }
    print("Set car position: \(pos)")
    car.position = pos
  }

  func turnLeft() {
    changeDirection(by: -90.0)
  }

  func turnRight() {
    changeDirection(by: 90.0)
  }

  func changeDirection(by angle: Float) {
    guard let car = self.carObject, gameState == .play else { return }
    print("Turn car by angle: \(angle)")
    car.changeDirection(by: angle)
  }

}
