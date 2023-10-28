//
//  SavedFoodbankView.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 20/10/2023.
//

import SwiftUI

struct SavedFoodbankView: View {
    @Environment(DataController.self) private var dataController
    @AppStorage("foodbankID") var foodbankID = "westminster"

    static var tag = "saved"

    @State private var state = LoadState.notSelected

    var body: some View {
        NavigationStack {
            Group {
                switch state {
                case .notSelected:
                    NoFoodBankView()
                case .loading:
                    ProgressView("Loading…")
                case .loaded(let foodbank):
                    SelectedFoodbankView(foodbank: foodbank)
                default:
                    Text("Failed")
                }
            }
            .toolbar {
                Button("Clear") {
                    foodbankID = ""
                    state = .notSelected
                }
            }
        }
        .task {
            await fetchFoodBank()
        }
    }

    func fetchFoodBank() async {
        guard foodbankID != "" else {
            state = .notSelected
            return
        }

        state = .loading
        state = await dataController.loadFoodbank(for: foodbankID)
    }
}

#Preview {
    SavedFoodbankView()
        .environment(DataController())
}
