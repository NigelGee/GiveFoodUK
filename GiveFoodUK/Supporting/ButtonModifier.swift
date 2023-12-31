//
//  ButtonModifier.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 19/10/2023.
//

import SwiftUI

/// A Button style to give Rounded Rectangle to a given Color
struct BorderedColor: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(color)
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .clipShape(.rect(cornerRadius: 8))
            .overlay(
                Color.black
                    .opacity(configuration.isPressed ? 0.3 : 0)
                    .clipShape(.rect(cornerRadius: 10))
            )
            .frame(minHeight: 44)
            .hoverEffect()
    }
}

extension ButtonStyle where Self == BorderedColor {
    static func borderedColor(with color: Color) -> Self {
        BorderedColor(color: color)
    }
}
