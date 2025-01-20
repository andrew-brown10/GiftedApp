//
//  HomeView.swift
//  GiftedApp
//
//  Created by Zach Stevens-Lindsey on 12/15/24.
//


import SwiftUI

struct HomeView: View {
    @State private var isSomeoneNewTapped = false
    @State private var relationshipToUser = ""
    @State private var name = ""
    @State private var age : Int = 0
    @State private var isSomeoneFromGiftCircleTapped = false
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if !isSomeoneNewTapped && !isSomeoneFromGiftCircleTapped {
                    Text("Who are you shopping for?")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading) // Left align the text
                        .padding(.horizontal)
                        .padding(.top)
                    
                    VStack(spacing: 10) {
                        createButton(
                            title: "Someone new",
                            color: Color("GiftedRedColor"),
                            imageName: "person.badge.plus",
                            action: {
                                print("Someone New tapped")
                                isSomeoneNewTapped = true
                            }
                        )
                        
                        createButton(
                            title: "Someone from my gift circle",
                            color: .pink,
                            imageName: "person.3.fill",
                            action: {
                                print("Someone from My Guest List tapped")
                                isSomeoneFromGiftCircleTapped = true
                            }
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                } else if isSomeoneNewTapped {
                    // Make other buttons here, for picking relationship
                    
                    if relationshipToUser != "" {
                        // Then make prompts here to get more info
                        // And maybe a checkbox for 18+
                        // Submit button last
                    }
                    
                    // Do gift generation thing here...
                } else if isSomeoneFromGiftCircleTapped {
                    // Do gift generation thing here...
                }

                Spacer()
            }
            .padding()
        }
        .onAppear {
            // Reset the state when the view appears
            resetState()
        }
    }
    
    private func resetState() {
        isSomeoneNewTapped = false
        name = ""
        age = 0
        isSomeoneFromGiftCircleTapped = false
    }
    
    private func createButton(
        title: String,
        color: Color,
        imageName: String,
        imageHeight: CGFloat = 30, // Default height
        imageWidth: CGFloat = 30,  // Default width
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            VStack {
                Image(systemName: imageName) // Replace with your custom logo if needed
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .foregroundColor(.white)
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame (height: 250, alignment: .center)
            .background(color)
            .cornerRadius(12)
        }
    }
    
}


