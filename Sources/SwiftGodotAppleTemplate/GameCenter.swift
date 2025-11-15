//
//  GameCenter.swift
//  SwiftGodotAppleTemplate
//
//  Created by Miguel de Icaza on 11/15/25.
//

import SwiftGodotRuntime
import SwiftUI
import UIKit

import GameKit

@Godot
class GameCenterManager: RefCounted, @unchecked Sendable {
    @Signal var authentication_error: SignalWithArguments<String>
    @Signal var authentication_result: SignalWithArguments<Bool>

    var isAuthenticated: Bool = false

    @Callable
    func authenticate() {
        let localPlayer = GKLocalPlayer.local

        localPlayer.authenticateHandler = { viewController, error in
            if let vc = viewController {
                // Present Game Center login UI
                // You must present this from your current root view controller
                topMostViewController.present(viewController, animated: true)
                return
            }

            if let error = error {
                authentication_error.emit(String(describing: error))
            }

            self.isAuthenticated = localPlayer.isAuthenticated
            authentication_result.emit(isAuthenticated)
        }
    }
}
