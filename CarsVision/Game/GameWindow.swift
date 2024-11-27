//
//  GameWindow.swift
//  CarsVision
//
//  Created by Narek Aslanyan on 27.11.24.
//

import SwiftUI

struct GameWindow: View {

  @Environment(\.openImmersiveSpace) var openImmersiveSpace
  @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
  @Environment(\.openWindow) var openWindow
  @Environment(\.dismissWindow) var dismissWindow
  @Environment(\.appModel) private var appModel
  @State private var isShowImmersiveSpace: Bool = false

  var body: some View {
    VStack {
      Text("Drive Car")
        .font(.system(size: 38))

      switch appModel.state {
      case .start:
        startPlacingButton
      case .placeCar:
        cancelPlacingButton
      case .placed:
        startPlayingButton
      case .play:
        stopPlayingButton
        // Temporary, until we talk about handtracking
        HStack(spacing: 20) {
          turnLeftButton
          turnRightButton
        }
      case .end:
        restartGameButton
      }
      if isShowImmersiveSpace {
        dismissImmersiveSpaceButton
      }
    }
    .padding()
  }
  
  private var startPlacingButton: some View {
    Button(action: {
      self.appModel.state = .placeCar
      GameController.shared.changeState(to: appModel.state)

      if !isShowImmersiveSpace {
        Task {
          await dismissImmersiveSpace()
          await openImmersiveSpace(id: "game_space")
        }
      }
      isShowImmersiveSpace = true
    }) {
      Text("Start Placing")
        .font(.largeTitle)
        .fontWeight(.regular)
        .padding()
        .cornerRadius(8)
    }
    .padding()
    .buttonStyle(.bordered)
  }
  
  private var cancelPlacingButton: some View {
    Button(action: {
      appModel.state = .start
      GameController.shared.changeState(to: appModel.state)
    }) {
      Text("Cancel Placing")
        .font(.largeTitle)
        .fontWeight(.regular)
        .padding()
        .cornerRadius(8)
    }
    .padding()
    .buttonStyle(.bordered)
  }
  
  private var startPlayingButton: some View {
    Button(action: {
      appModel.state = .play
      GameController.shared.changeState(to: appModel.state)
    }) {
      Text("Start Playing")
        .font(.largeTitle)
        .fontWeight(.regular)
        .padding()
        .cornerRadius(8)
    }
    .padding()
    .buttonStyle(.bordered)
  }
  
  private var stopPlayingButton: some View {
    Button(action: {
      appModel.state = .placed
      GameController.shared.changeState(to: appModel.state)
    }) {
      Text("Stop Playing")
        .font(.largeTitle)
        .fontWeight(.regular)
        .padding()
        .cornerRadius(8)
    }
    .padding()
    .buttonStyle(.bordered)
  }
  
  private var turnLeftButton: some View {
    Button(action: {
      GameController.shared.turnLeft()
    }) {
      Image(systemName: "arrowshape.backward.fill")
        .font(.largeTitle)
        .fontWeight(.bold)
        .padding()
        .cornerRadius(8)
    }
    .padding()
    .buttonStyle(.bordered)
  }
  
  private var turnRightButton: some View {
    Button(action: {
      GameController.shared.turnRight()
    }) {
      Image(systemName: "arrowshape.right.fill")
        .font(.largeTitle)
        .fontWeight(.bold)
        .padding()
        .cornerRadius(8)
    }
    .padding()
    .buttonStyle(.bordered)
  }
  
  private var restartGameButton: some View {
    Button(action: {
      appModel.state = .placed
      GameController.shared.changeState(to: appModel.state)
    }) {
      Text("Restart Game")
        .font(.largeTitle)
        .fontWeight(.regular)
        .padding()
        .cornerRadius(8)
    }
    .padding()
    .buttonStyle(.bordered)
  }
  
  private var dismissImmersiveSpaceButton: some View {
    Button {
      Task {
        await dismissImmersiveSpace()
        isShowImmersiveSpace = false
        self.appModel.state = .start
        GameController.shared.changeState(to: appModel.state)
      }
    } label: {
      Text("Dismiss Immersive")
        .font(.largeTitle)
        .fontWeight(.regular)
        .padding()
        .cornerRadius(8)
    }
  }
  
}
