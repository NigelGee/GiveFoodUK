//
//  URLSession-Decodable.swift
//  GiveFoodUK
//
//  Created by Nigel Gee on 26/10/2023.
//

import Foundation

/// A URLSession extension that fetches data from a URL and decodes to some Decodable type.
/// Usage: let user = try await URLSession.shared.decode(UserData.self, from: someURL)
/// Note: this requires Swift 5.5.
extension URLSession {
    func decode<T: Decodable>(
        _ type: T.Type = T.self,
        from url: URL,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) async throws  -> T {
        let (data, _) = try await data(from: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dataDecodingStrategy = dataDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy

        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
}
