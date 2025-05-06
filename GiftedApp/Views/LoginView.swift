//
//  LoginView.swift
//  GiftedApp
//
//  Created by Andrew Brown on 1/11/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authHelper: AuthHelper
    @EnvironmentObject var userSlice: UserSlice
    
    @State private var password = ""
    @State private var userChoice = nil as String?
    
    var body: some View {
        if userChoice == nil {
            SignInOrSignUpView(userChoice: $userChoice)
        }
        else if userChoice == "signIn" {
            SignInView(userChoice: $userChoice)
        }
        else if userChoice == "signUp" {
            SignUpView(userChoice: $userChoice)
        }
    }
}

struct SignInOrSignUpView: View {
    @EnvironmentObject var authHelper: AuthHelper
    @EnvironmentObject var userSlice: UserSlice
    @Binding var userChoice: String?
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                // Left Side
                VStack {
                    Spacer()
                    Text("Sign-In")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .onTapGesture {
                            userChoice = "signIn"
                        }
                    Spacer()
                }
                .frame(width: geometry.size.width / 2)
                .background(Color.white)
                
                // Vertical Line
                Rectangle()
                    .frame(width: 2, height: geometry.size.height * 0.9)
                    .foregroundColor(.gray)
                
                // Right Side
                VStack {
                    Spacer()
                    Text("Sign-Up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .onTapGesture {
                            userChoice = "signUp"
                        }
                    Spacer()
                }
                .frame(width: geometry.size.width / 2)
                .background(Color.white)
            }
        }
        .background(Color.white) // Background color for the entire view
        .edgesIgnoringSafeArea(.all)
    }
}

struct SignInView: View {
    @EnvironmentObject var authHelper: AuthHelper
    @State private var email: String
    @State private var password: String
    @Binding var userChoice: String?
    
    public init(userChoice: Binding<String?>) {
            self._userChoice = userChoice
            self._email = State(initialValue: "")
            self._password = State(initialValue: "")
        }
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                authHelper.signIn(email: email, password: password)
            }) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        HStack {
            Text("Forgot Password?")
            Rectangle()
                .frame(width: 2, height: 20)
                .foregroundColor(.blue)
            Text("Sign Up Instead")
                .onTapGesture {
                    userChoice = "signUp"
                }
        }
        
    }
}

struct SignUpView: View {
    
    @EnvironmentObject var authHelper: AuthHelper
    @EnvironmentObject var userSlice: UserSlice
    @State private var firstName: String
    @State private var lastName: String
    @State private var email: String
    @State private var password: String
    @Binding var userChoice: String?
    
    public init(userChoice: Binding<String?>) {
            self._userChoice = userChoice
            self._email = State(initialValue: "")
            self._password = State(initialValue: "")
            self._firstName = State(initialValue: "")
            self ._lastName = State(initialValue: "")
        }
    
    var body: some View {
        VStack {
            TextField("First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                authHelper.signUp(email: email, password: password)
                Task {
                    await userSlice.createUser(userId: authHelper.userId, firstName: firstName, lastName: lastName, email: email)
                }
            }) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        HStack {
            Text("Forgot Password?")
            Rectangle()
                .frame(width: 2, height: 20)
                .foregroundColor(.blue)
            Text("Sign Up Instead")
                .onTapGesture {
                    userChoice = "signUp"
                }
        }
        Text("Error: \(authHelper.errorMessage ?? "")")
            .foregroundColor(.red)
    }
}



#Preview {
    LoginView()
        .environmentObject(AuthHelper())
        .environmentObject(UserSlice())
}
