//
//  DataController.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 17/10/2023.
//

import SwiftUI

enum LoadState {
    case loading, failed, loadedLocation([FoodbankLocation]), loaded(Foodbank), notSelected
}

@Observable
class DataController {
    func loadFoodbanks(_ searchType: SearchType, for criteria: String) async -> LoadState {
        let fullURL = searchType.rawValue + criteria
        print(fullURL)

        guard let url = URL(string: fullURL) else { return .failed }

        do {
            let foodbanks = try await URLSession.shared.decode([FoodbankLocation].self, from: url)

            if searchType == .currentLocation {
                return .loadedLocation(foodbanks.filter { $0.type == "organisation" })
            }

            return .loadedLocation(foodbanks)
        } catch {
            return .failed
        }
    }

    func loadFoodbank(for foodbankID: String) async -> LoadState {
        
        let fullURL = "https://www.givefood.org.uk/api/2/foodbank/\(foodbankID)"
        print(fullURL)

        guard let url = URL(string: fullURL) else { return .failed }

        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd'T'HH:mm:ss.SSS"

        do {
            let foodbank = try await URLSession.shared.decode(Foodbank.self, from: url, dateDecodingStrategy: .formatted(formatter))
            return .loaded(foodbank)
        } catch {
            return .failed
        }
    }
}

