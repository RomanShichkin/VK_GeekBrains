//
//  NetworkDataFetcher.swift
//  VK_GeekBrains
//
//  Created by Роман Шичкин on 28.07.2021.
//

import Foundation

class NetworkDataFetcher {
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
}
