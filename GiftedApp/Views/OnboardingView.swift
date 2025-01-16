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
                        GiftedClient.shared.CreateUser(userId: userSlice.user?.Id, firstName: firstName, lastName: lastName, email: userSlice.user?.Email)
                        Task {
                            await userSlice.fetchUserProfile(userId: <#T##String#> )
                        }
                    }

                }
        }
        .padding()
    }
}
