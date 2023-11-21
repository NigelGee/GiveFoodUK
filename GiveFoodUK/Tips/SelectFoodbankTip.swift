//
//  SelectFoodbankTip.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 23/10/2023.
//

import TipKit

/// A View that show how to save and select a food bank
struct SelectFoodbankTip: Tip {
    var title: Text {
        Text("Select a Foodbank")
            .font(.title)
    }

    var message: Text? {
        Text("Tap a card to select and save foodbank.")
    }

    var image: Image? {
        Image(systemName: "rectangle.and.hand.point.up.left.fill")
            .symbolRenderingMode(.hierarchical)
    }
}
