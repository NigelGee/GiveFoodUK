//
//  ButtonModifiler.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 19/10/2023.
//

import SwiftUI

struct BorderedColor: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
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
