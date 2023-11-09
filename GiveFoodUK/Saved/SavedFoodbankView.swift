//
//  SavedFoodbankView.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 20/10/2023.
//

import SwiftUI

struct SavedFoodbankView: View {
    @Environment(DataController.self) private var dataController
    @AppStorage("foodbankID") var foodbankID = "bath"

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
                    NoInternetView {
                        Task {
                            await fetchFoodBank()
                        }
                    }
                }
            }
            .toolbar {
                if foodbankID.isNotEmpty {
                    ToolbarItem(placement: .destructiveAction) {
                        Button {
                            foodbankID = ""
                            state = .notSelected
                        } label: {
                            Label("Clear Food bank", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .task {
            await fetchFoodBank()
        }
    }

    func fetchFoodBank() async {
        guard foodbankID.isNotEmpty else {
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
