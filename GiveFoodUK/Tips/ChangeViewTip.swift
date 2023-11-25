//
//  ChangeViewTip.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 23/10/2023.
//

import TipKit

/// A view that will show how to switch between List and Map View
struct ChangeViewTip: Tip {
    static let changeViewEvent = Event(id: "changeViewEvent")

    var options: [TipOption] {
        Tips.MaxDisplayCount(1)
    }

    var title: Text {
        Text("Change to Map View")
    }

    var message: Text? {
        Text("Toggle between Map View and List View")
    }

    var image: Image? {
        Image(systemName: "map")
    }

    var rules: [Rule] {
        #Rule(Self.changeViewEvent) { event in
            event.donations.count >= 3
        }
    }
}
