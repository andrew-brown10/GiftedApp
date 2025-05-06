//
//  UserSlice.swift
//  GiftedApp
//
//  Created by Andrew Brown on 1/15/25.
//

import Foundation

@MainActor
class UserSlice: ObservableObject {
    @Published var user: User?
    
    func fetchUserProfile(userId: String) async {
        do {
            let fetchedUser = try await GiftedClient.shared.getUser(userId: userId)
            DispatchQueue.main.async {
                self.user = fetchedUser
            }
        } catch {
            print("Error fetching user profile: \(error)")
        }
    }
    
    func createUser(userId: String, firstName: String, lastName: String, email: String) async {
        do {
            let newUser = CreateUserRequestModel(Id: userId, FirstName: firstName, LastName: lastName, Email: email)
            let createdUser = try await GiftedClient.shared.CreateUser(user: newUser)
            DispatchQueue.main.async {
                self.user = createdUser
            }
        } catch {
            print("Error creating user: \(error)")
        }
    }
}
