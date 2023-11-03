//
//  Foodbank.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 17/10/2023.
//

import CoreLocation
import SwiftUI

struct Foodbank: Codable, Identifiable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case name, slug, phone, email, address, location = "lat_lng", URLS = "urls", charity, locations, politics, items = "need", nearbyFoodbanks = "nearby_foodbanks"
    }

    var id: String { slug }
    var name: String
    var slug: String
    var phone: String
    var email: String
    var address: String
    var location: String

    var URLS: URLS
    var charity: Charity
    var locations: [Location]?
    var politics: Politics
    var items: Items
    var nearbyFoodbanks: [NearbyFoodbank]

    var neededItems: [Items] {
        let baseList = items.needs.components(separatedBy: .newlines)

        return baseList.map { Items(id: UUID().uuidString, needs: $0) }
    }

    var excessItems: [Items]? {
        if items.excess != "" {
            if let items = items.excess?.components(separatedBy: .newlines) {
                if items.isNotEmpty {
                    return items.map { Items(id: UUID().uuidString, needs: "", excess: $0)}
                }
            }
        }

        return nil
    }

    var coordinate: CLLocationCoordinate2D? {
        let components = location.split(separator: ",").compactMap(Double.init)
        guard components.count == 2 else { return nil }

        return CLLocationCoordinate2D(latitude: components[0], longitude: components[1])
    }

    var formattedPhone: String {
        if phone.contains("x") {
            var newPhone = ""
            for tel in phone {
                if tel == "x" { break }
                newPhone.append(tel)
            }
            return newPhone
        }
        return phone
    }

    static let example = Foodbank(name: "Westminster", slug: "westminster", phone: "02078341731x224", email: "foodbank@westminsterchapel.org.uk", address: "Westminster Chapel\r\nBuckingham Gate\r\nLondon\r\nSW1E 6BS", location: "51.49888499999999,-0.138101", URLS: .example, charity: .example, locations: [], politics: .example, items: .example, nearbyFoodbanks: [.example])

}

extension Foodbank {
    struct Items: Codable, Identifiable, Hashable {
        var id: String
        var needs: String
        var excess: String?
        var created: Date?

        static let example = Items(id: "7e4e53b3", needs: "UHT Milk\nLong-Life Fruit Juice\nCooking Oil\nDrinking Chocolate\nJam\nMashed Potatoes", excess: "Example Excess Items", created: .now)
    }

    struct Charity: Codable, Hashable {
        private enum CodingKeys: String, CodingKey {
            case registrationID = "registration_id", registerURL = "register_url"
        }
        
        var registrationID: String?
        var registerURL: String?

        static let example = Charity(registrationID: "1144831", registerURL: "https://register-of-charities.charitycommission.gov.uk/charity-details/?regid=1144831&subid=0")
    }

    struct Politics: Codable, Hashable {
        private enum CodingKeys: String, CodingKey {
            case parliamentaryConstituency = "parliamentary_constituency", mp, mpParty = "mp_party", ward, district
        }

        var parliamentaryConstituency: String
        var mp: String
        var mpParty: String
        var ward: String
        var district: String

        var rosetteColor: Color {
            switch mpParty {
            case "Conservative": .blue
            case "Labour": .red
            case "Labour Co-operative": .red
            case "Liberal Democrats": .orange
            case "SNP": .yellow
            case "Scottish National Party": .yellow
            default: .secondary
            }
        }

        static let example = Politics(parliamentaryConstituency: "Cities of London and Westminster", mp: "Nickie Aiken", mpParty: "Conservative", ward: "St James's", district: "Westminster")
    }

    struct URLS: Codable, Hashable {
        private enum CodingKeys: String, CodingKey {
            case shoppingList = "shopping_list", homepage
        }

        var shoppingList: String?
        var homepage: String

        static let example = URLS(shoppingList: "https://bath.foodbank.org.uk/give-help/donate-food/", homepage: "https://bath.foodbank.org.uk")
    }

    struct NearbyFoodbank: Codable, Hashable, Identifiable {
        private enum CodingKeys: String, CodingKey {
            case name, slug, address, location = "lat_lng"
        }
        
        var id: String { name }
        var name: String
        var slug: String
        var address: String
        var location: String

        var coordinate: CLLocationCoordinate2D? {
            let components = location.split(separator: ",").compactMap(Double.init)
            guard components.count == 2 else { return nil }

            return CLLocationCoordinate2D(latitude: components[0], longitude: components[1])
        }

        static let example = NearbyFoodbank(name: "Bradford on Avon", slug: "bradford-on-avon", address: "The Hub @ BA15\r\nChurch Street\r\nBradford on Avon\r\nBA15 1LS", location: "51.3478187,-2.2514713")
    }
}

