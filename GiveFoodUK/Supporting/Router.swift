//
//  Router.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 24/10/2023.
//

import SwiftUI

/// A model to track the Navigation Path
class Router: ObservableObject {
    @Published var path = NavigationPath()

    func reset() {
        path = NavigationPath()
    }
}
