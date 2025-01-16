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
            
            // Print the URL to verify it
            print("URL: \(url)")
            
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                
                // Print the response to debug
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                }
                
                // Print the data to debug
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response Data: \(jsonString)")
                }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(Person.self, from: data)
            } catch {
                print("Error: \(error.localizedDescription)")
                throw GiftedError.invalidData
            }
        }
        
        func getUser(userId: String) async  throws -> User {
            let endpoint = Endpoints.getUser + "/id=\(userId)"
            guard let url = URL(string: endpoint) else {
                throw GiftedError.invalidURL
            }
            
            print("URL: \(url)")
            
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                
                // Print the response to debug
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                }
                
                // Print the data to debug
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response Data: \(jsonString)")
                }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                return try decoder.decode(User.self, from: data)
            } catch {
                print("Error: \(error.localizedDescription)")
                throw GiftedError.invalidData
            }
        }
        
        func CreateUser(userId: String, firstName: String, lastName: String) async  throws -> User {
            let endpoint = Endpoints.getUser + "/id=\(userId)"
            guard let url = URL(string: endpoint) else {
                throw GiftedError.invalidURL
            }
            
            print("URL: \(url)")
            
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                
                // Print the response to debug
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                }
                
                // Print the data to debug
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response Data: \(jsonString)")
                }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                return try decoder.decode(User.self, from: data)
            } catch {
                print("Error: \(error.localizedDescription)")
                throw GiftedError.invalidData
            }
        }
}


enum GiftedError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

