//
//  ColorEffectModifier.swift
//  GiveFoodUK
//
//  Created by Nigel Gee on 23/11/2023.
//

import SwiftUI

/// A modifier that uses the colorScheme and changes black pixel to white with a Shader
struct ColorEffect: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        if colorScheme == .dark {
            content
                .colorEffect(ShaderLibrary.inverseBlack())
        } else {
            content
        }
    }
}

extension View {

    /// A modifier that uses the colorScheme and changes black pixel to white with a Shader
    var colorSchemeEffect: some View {
        modifier(ColorEffect())
    }
}
