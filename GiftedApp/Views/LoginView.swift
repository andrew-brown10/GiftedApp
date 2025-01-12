//
//  LoginView.swift
//  GiftedApp
//
//  Created by Andrew Brown on 1/11/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthHelper
    
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                HStack {
                    Button("Sign In") {
                        viewModel.signIn(email: email, password: password)
                    }
                    Button("Sign Up") {
                        viewModel.signUp(email: email, password: password)
                    }
                }
                Text(viewModel.errorMessage ?? "")
                    .foregroundColor(.red)
        }
        .padding()
    }
}
