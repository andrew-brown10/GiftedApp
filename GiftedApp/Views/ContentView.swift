//
//  ContentView.swift
//  GiftedApp
//
//  Created by Andrew Brown on 12/14/24.
//

import SwiftUI
import SwiftData



struct ContentView: View {
    @EnvironmentObject var authHelper: AuthHelper
    @StateObject private var userSlice = UserSlice()

    var body: some View {
        //If user is not signed in, show the login screen
        if !authHelper.isSignedIn {
            LoginView()
                .environmentObject(userSlice)
        }
        //If user is signed in but has not completed onboard, show the onboarding screen
        if authHelper.isSignedIn && userSlice.user?.FirstName == nil {
            OnboardingView()
                .environmentObject(userSlice)
        }
            
        //If user is signed in and completed onboard, show the main app
        if authHelper.isSignedIn && userSlice.user?.FirstName != nil {
            VStack(spacing: 0) { // Stack elements vertically
                BannerView() // Add the banner at the top
                SwiftUIView()
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                    
                    GiftCircleView()
                        .tabItem {
                            Label("Gift Circle", systemImage: "person.3.fill")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.crop.circle.fill")
                        }
                    
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gearshape.fill")
                        }
                }
                .tint(Color("GiftedRedColor"))
            }
        }
    }
}

struct GiftCircleView: View {
    var body: some View {
        Text("Gift Circle")
            .font(.largeTitle)
            .padding()
    }
}

struct ProfileView: View {
    @EnvironmentObject var authHelper: AuthHelper

    var body: some View {
        VStack() {
            Text("User Id: \($authHelper.userId.wrappedValue)")
                .font(.title)
                
                
            Button("Sign Out") {
                authHelper.signOut()
            }
        }
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings")
            .font(.largeTitle)
            .padding()
    }
}
