//
//  AuthHelper.swift
//  GiftedApp
//
//  Created by Andrew Brown on 1/11/25.
//

import SwiftUI
import FirebaseAuth

class AuthHelper: ObservableObject {
    @Published var user: User? = nil
    @Published var isSignedIn: Bool = false
    @Published var errorMessage: String? = nil // For showing errors
    @Published var userId: String = ""


    init() {
        self.user = Auth.auth().currentUser
        if let user = Auth.auth().currentUser {
            self.userId = user.uid
        }
        self.isSignedIn = user != nil
    }

    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Sign Up Error: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
                return
            }
            self.user = result?.user
            if let user = Auth.auth().currentUser {
                self.userId = user.uid
            }
            self.isSignedIn = true
        }
    }

    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Sign In Error: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
                return
            }
            self.user = result?.user
            if let user = Auth.auth().currentUser {
                self.userId = user.uid
            }
            self.isSignedIn = true
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.userId = ""
            self.isSignedIn = false
        } catch {
            print("Sign Out Error: \(error.localizedDescription)")
            self.errorMessage = error.localizedDescription
        }
    }
}
