//
//  OnboardingView.swift
//  GiftedApp
//
//  Created by Andrew Brown on 1/15/25.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var userSlice: UserSlice
    
    @State private var firstName = ""
    @State private var lastName = ""

    var body: some View {
        VStack {
                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField("LastName", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                HStack {
                    Button("Next") {
                        GiftedClient.shared.createUser(firstName: firstName, lastName: lastName)
                        Task {
                            await userSlice.fetchUserProfile(userId: <#T##String#> )
                        }
                    }
                    Button("Sign Up") {
                        viewModel.signUp(email: email, password: password)
                        Task {
                            await userSlice.fetchUserProfile(userId: <#T##String#>)
                        }
                    }
                }
                Text(viewModel.errorMessage ?? "")
                    .foregroundColor(.red)
        }
        .padding()
    }
}
