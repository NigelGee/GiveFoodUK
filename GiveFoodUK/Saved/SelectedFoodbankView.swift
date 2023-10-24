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
        NavigationStack {
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

                Section("Requested Items") {
                    ForEach(foodbank.neededItems) { item in
                        Text(item.needs)
                    }
                }
            }
            .navigationTitle("\(foodbank.name)'s Foodbank")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Clear") {
                    dataController.select(nil)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SelectedFoodbankView(foodbank: .example)
            .environment(DataController())
    }
}
