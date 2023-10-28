//
//  SelectedFoodbankView.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 20/10/2023.
//

import SwiftUI

struct SelectedFoodbankView: View {
    @Environment(DataController.self) private var dataController

    let foodbank: Foodbank

    var body: some View {
            List {
                Section {
                    NavigationLink("Details") {
                        DetailFoodbankView(foodbank: foodbank)
                    }
                    
                    NavigationLink("Drop-Off Point") {
                        DropOffView(foodbank: foodbank)
                    }

                }
                
                if let shoppingList = foodbank.URLS.shoppingList {
                    if let shoppingListURL = URL(string: shoppingList) {
                        Link("Foodbank's Shopping List", destination: shoppingListURL)
                    }
                }

                Section {
                    ForEach(foodbank.neededItems) { item in
                        Text(item.needs)
                    }
                } header: {
                    Text("Requested Items")
                } footer: {
                    Text("Created on \(foodbank.items.formattedDate)")
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
