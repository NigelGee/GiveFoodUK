//
//  SearchType-enum.swift
//  GiveFoodUK
//
//  Created by Nigel Gee on 27/10/2023.
//

import Foundation

/// A enum to hold the URL string to decode depending on if PostCode/Town or Current Location search
enum SearchType: String {
    case postcode = "https://www.givefood.org.uk/api/2/foodbanks/search/?address="
    case currentLocation = "https://www.givefood.org.uk/api/2/locations/search/?lat_lng="
}
