//
//  SwiftUIIntegration.swift
//  SwiftGodotAppleTemplate
//
//  Created by Miguel de Icaza on 11/14/25.
//


import SwiftUI

@MainActor
func presentSwiftUIOverlayFromTopMost<V: View>(_ view: V) {
    guard let presenter = topMostViewController() else {
        return
    }

    let hosting = UIHostingController(rootView: view)
    hosting.modalPresentationStyle = .formSheet
    hosting.view.backgroundColor = .clear

    presenter.present(hosting, animated: true)
}
