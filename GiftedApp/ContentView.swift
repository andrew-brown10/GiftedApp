//
//  ContentView.swift
//  GiftedApp
//
//  Created by Andrew Brown on 12/14/24.
//

import SwiftUI
import SwiftData



struct ContentView: View {
    var body: some View {
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

struct GiftCircleView: View {
    var body: some View {
        Text("Gift Circle")
            .font(.largeTitle)
            .padding()
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile")
            .font(.largeTitle)
            .padding()
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings")
            .font(.largeTitle)
            .padding()
    }
}
