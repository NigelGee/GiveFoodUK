//
//  ChangeViewTip.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 23/10/2023.
//

import Foundation
import TipKit

struct ChangeViewTip: Tip {
    var title: Text {
        Text("Change to Map View")
    }

    var message: Text? {
        Text("Tap to change to Map View")
    }

    var image: Image? {
        Image(systemName: "map")
    }
}
