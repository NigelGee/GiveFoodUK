//
//  ShapeStyle-Color.swift
//  GiveFoodUK
//
//  Created by Nigel Gee on 07/11/2023.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    static var activeColor: Color { Color(red: 0.894, green: 0.937, blue: 0.976) }
    static var inactiveColor: Color { Color(red: 0.937, green: 0.961, blue: 0.984) }
    static var titleColor: Color { Color("titleColor") }
}
