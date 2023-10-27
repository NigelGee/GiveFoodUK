//
//  DataController.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 17/10/2023.
//

import SwiftUI

enum LoadState {
    case loading, failed, loaded([FoodbankLocation])
}

@Observable
class DataController {
    private(set) var selectedFoodbank: Foodbank?

    private let savePath = URL.documentsDirectory.appending(path: "SelectedFoodbank")

    init() {
        do {
            let data = try Data(contentsOf: savePath)
            let savedFoodbank = try JSONDecoder().decode(Foodbank.self, from: data)
            select(savedFoodbank)
        } catch {

        }
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(selectedFoodbank)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }

    func loadFoodbanks(_ searchType: SearchType, for criteria: String) async -> LoadState {
        let fullURL = searchType.rawValue + criteria
        print(fullURL)

        guard let url = URL(string: fullURL) else { return .failed }

        do {
            let foodbanks = try await URLSession.shared.decode([FoodbankLocation].self, from: url)

            if searchType == .currentLocation {
                return .loaded(foodbanks.filter { $0.type == "organisation" })
            }

            return .loaded(foodbanks)
        } catch {
            return .failed
        }
    }

    func select(_ foodbank: Foodbank?) {
        selectedFoodbank = foodbank
        save()

        Task {
            await updateSelected()
        }
    }

    private func updateSelected() async {
        guard let current = selectedFoodbank else { return }

        let fullURL = "https://www.givefood.org.uk/api/2/foodbank/\(current.slug)"
        guard let url = URL(string: fullURL) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            selectedFoodbank = try decoder.decode(Foodbank.self, from: data)
        } catch {
            print("Failed to decode: \(error.localizedDescription)")
        }
    }
}

