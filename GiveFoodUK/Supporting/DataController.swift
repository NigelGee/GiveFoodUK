//
//  DataController.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 17/10/2023.
//

import SwiftUI

/// A enum to hold the state of loading food banks
enum LoadState {
    case loading, failed, loadedLocation([FoodbankLocation]), loaded(Foodbank), notSelected
}

@Observable
class DataController {
    let locationManager = LocationManager()

    /// A method to load food banks on given criteria based on searchType (currentLocation/Postcode)
    /// - Parameters:
    ///   - searchType: of Postcode or Current Location
    ///   - criteria: Either postcode/town or current location
    /// - Returns: A state of loading state
    func loadFoodbanks(_ searchType: SearchType, for criteria: String) async -> LoadState {
        var fullURL = ""

        switch searchType {
        case .postcode:
            fullURL = searchType.rawValue + criteria
        case .currentLocation:
            await locationManager.requestLocation()

            try? await Task.sleep(for: .seconds(2))

            guard let location = locationManager.location else { return .failed }

            fullURL = searchType.rawValue + "\(location.latitude),\(location.longitude)"
        }

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
    
    /// A method that load a selected food bank
    /// - Parameter foodbankID: The ID of selected food bank
    /// - Returns: A state of loading state
    func loadFoodbank(for foodbankID: String) async -> LoadState {
        let fullURL = "https://www.givefood.org.uk/api/2/foodbank/\(foodbankID)"

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

