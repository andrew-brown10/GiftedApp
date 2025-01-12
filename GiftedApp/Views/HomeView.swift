//
//  HomeView.swift
//  GiftedApp
//
//  Created by Zach Stevens-Lindsey on 12/15/24.
//


import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Home")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Home")
        }
    }
}
