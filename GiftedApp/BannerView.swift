//
//  BannerView.swift
//  GiftedApp
//
//  Created by Zach Stevens-Lindsey on 12/15/24.
//


import SwiftUI

struct BannerView: View {
    var body: some View {
        ZStack {
            // Background Color
            Color("GiftedRedColor")
                .ignoresSafeArea(edges: .top) // Extend to the top of the screen
            
            // App Name
            Text("Gifted")
                .font(.title) // Large font size
                .fontWeight(.bold)
                .foregroundColor(.white) // Text color
        }
        .frame(height: 40) // Set the height of the banner
    }
}
