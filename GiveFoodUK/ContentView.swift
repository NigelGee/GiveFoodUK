//
//  ContentView.swift
//  GiveFoodUK
//
//  Created by Nigel Gee on 24/10/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(DataController.self) var dataController

    /// A property to store which tab was selected last
    @AppStorage("selectedView") var selectedView: String = EnterLocationView.tag

    var body: some View {
        TabView(selection: $selectedView) {
            EnterLocationView()
                .tag(EnterLocationView.tag)
                .tabItem { Label("Search", systemImage: "magnifyingglass") }

            SavedFoodbankView()
                .tag(SavedFoodbankView.tag)
                .tabItem { Label("Saved Foodbank", systemImage: "house") }
        }
    }
}

#Preview {
    ContentView()
        .environment(DataController())
        .environmentObject(Router())
}
