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

    var body: some View {
        //If user is not signed in, show the login screen
        if !authHelper.isSignedIn {
            LoginView()
        } else {
            VStack(spacing: 0) { // Stack elements vertically
                BannerView() // Add the banner at the top
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
