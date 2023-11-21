//
//  SelectedFoodbankView.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 20/10/2023.
//

import SwiftUI

/// A view of a selected food bank
struct SelectedFoodbankView: View {
    // FOR BETA TESTING TO SEE IF TO INCLUDE NEARBY FOODBANKS
    @State private var showNearbyFoodbanks = true

    @Environment(DataController.self) private var dataController

    let foodbank: Foodbank

    var body: some View {
            List {
                Section {
                    NavigationLink("Details") {
                        DetailFoodbankView(foodbank: foodbank)
                    }
                    
                    NavigationLink("Drop-Off Point") {
                        DropOffView(foodbank: foodbank, showNearbyFoodbanks: showNearbyFoodbanks)
                    }

                    // FOR BETA TESTING TO SEE IF TO INCLUDE NEARBY FOODBANKS
                    Toggle("*Show Nearby Food banks in Drop-Off screen (Beta Testing Only)*", isOn: $showNearbyFoodbanks)

                }
                
                Section {
                    if let shoppingList = foodbank.URLS.shoppingList {
                        if let shoppingListURL = URL(string: shoppingList) {
                            Link("Foodbank's Shopping List", destination: shoppingListURL)
                        }
                    }
                } footer: {
                    Text("The food bank shopping list on their own website might show additional items not yet added to requested items.")
                }

                Section {
                    ForEach(foodbank.neededItems) { item in
                        Text(item.needs)
                    }
                } header: {
                    Text("Requested Items")
                } footer: {
                    if let created = foodbank.items.created {
                        Text("Last updated on \(created.formatted(date: .long, time: .shortened))")
                    }
                }
                
                if let excessItems = foodbank.excessItems {
                    Section("Not Needed") {
                        ForEach(excessItems) { item in
                            Text(item.excess ?? "Unknown")
                                .foregroundStyle(.secondary)
                                .strikethrough()
                        }
                    }
                }
            }
            .navigationTitle("\(foodbank.name)'s Foodbank")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SelectedFoodbankView(foodbank: .example)
            .environment(DataController())
    }
}
