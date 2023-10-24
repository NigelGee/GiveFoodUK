//
//  SavedFoodbankView.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 20/10/2023.
//

import SwiftUI

struct SavedFoodbankView: View {
    @Environment(DataController.self) private var dataController

    static var tag = "saved"

    var body: some View {
        Group {
            if let foodbank = dataController.selectedFoodbank {
                SelectedFoodbankView(foodbank: foodbank)
            } else {
                ContentUnavailableView {
                    Label("No Foodbank Saved!", systemImage: "house")
                } description: {
                    Text("Select a food bank to save details.")
                }
            }
        }
    }
}

#Preview {
    SavedFoodbankView()
        .environment(DataController())
}
