//
//  Location.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 22/10/2023.
//

import CoreLocation
import Foundation

struct Location: Codable, Identifiable, Hashable {
    enum CodingKeys: String, CodingKey {
        case name, slug, address, location = "lat_lng"
    }

    var id: String { slug }
    var name: String
    var slug: String
    var address: String
    var location: String

    var coordinate: CLLocationCoordinate2D? {
        let components = location.split(separator: ",").compactMap(Double.init)
        guard components.count == 2 else { return nil }

        return CLLocationCoordinate2D(latitude: components[0], longitude: components[1])
    }
}
