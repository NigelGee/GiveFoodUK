//
//  FoodbankLocation.swift
//  GiveFoodUK
//
//  Created by Nigel Gee on 27/10/2023.
//

import CoreLocation
import Foundation

/// A model for decoding food banks from JSON
struct FoodbankLocation: Codable, Identifiable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case name, slug, foodbankDetail = "foodbank", address, location = "lat_lng", distance = "distance_m", type
    }
    var name: String
    var slug: String?
    var foodbankDetail: FoodbankDetail?
    var address: String
    var location: String
    var distance: Int
    var type: String?
    
    /// A property that uses a `slug` from JSON. In `Current Location` JSON the `slug` is in another property of "foodbank"
    var id: String {
        slug ?? foodbankDetail?.slug ?? ""
    }
    
    /// Format distance (in metric) to user preference
    var distanceFormatted: String {
        let measurement = Measurement(value: Double(distance), unit: UnitLength.meters)

        return measurement.formatted(.measurement(width: .abbreviated))
    }
    
    /// Format coordinates to `CLLocationCoordinate2D`
    var coordinate: CLLocationCoordinate2D? {
        let components = location.split(separator: ",").compactMap(Double.init)
        guard components.count == 2 else { return nil }

        return CLLocationCoordinate2D(latitude: components[0], longitude: components[1])
    }

    static let example = FoodbankLocation(name: "Bath", slug: "bath", address: "The Gateway Centre\r\nSnow Hill\r\nLondon Road\r\nBath\r\nBA1 6DH", location: "51.39113099999999,-2.3543577", distance: 1367)
}

extension FoodbankLocation {

    /// A struct to decode food banks when searching via `Current Location`
    struct FoodbankDetail: Codable, Hashable {
        var slug: String
    }
}
