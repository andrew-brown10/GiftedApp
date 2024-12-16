//
//  GiftedClient.swift
//  GiftedApp
//
//  Created by Andrew Brown on 12/15/24.
//

import Foundation

class GiftedClient {
    static let shared = GiftedClient()
    
    private init() {}
    
    func getCharacter() async throws -> Person {
        let endpoint = Endpoints.characters
        guard let url = URL(string: endpoint) else {
            throw GiftedError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(Person.self, from: data)
            } catch {
                throw GiftedError.invalidData
            }
        } catch {
            print("error: \(error.localizedDescription)")
            throw GiftedError.invalidURL
        }
        //guard let response = response as? HTTPURLResponse, response.statusCode == 200 else //{
          //  throw GiftedError.invalidResponse
        //}
        
        
    }
}

enum GiftedError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

