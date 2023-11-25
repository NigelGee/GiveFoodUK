//
//  GiveFoodUKApp.swift
//  GiveFoodUK
//
//  Created by Nigel Gee on 24/10/2023.
//

import SwiftUI
import TipKit

@main
struct GiveFoodUKApp: App {
    @State private var dataController = DataController()
    @StateObject var router = Router()
    
    /// Configure TipKit
    init() {
//        try? Tips.resetDatastore()
        try? Tips.configure()

    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataController)
                .environmentObject(router)
        }
    }
}
