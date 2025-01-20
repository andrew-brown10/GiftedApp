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
    @State private var answers: [String] = [] // Tracks answers to prompts
    @State private var isSomeoneFromGiftCircleTapped = false
    
    // Array of relationship options
    let relationships = ["Significant other", "Child", "Parent", "Sibling", "Friend", "Colleague", "Other"]
    
    let prompts = [
        "What's their name?",
        "How old are they?",
        "What's the occassion?",
        "What hobbies or activities do they enjoy?",
        "What’s a gift they’ve mentioned in the past?",
        "Do they prefer practical or sentimental gifts?",
        "What's your price range?",
    ]
    
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
                            imageName: "person.badge.plus",
                            imageHeight: 150,
                            buttonHeight: 250,
                            action: {
                                isSomeoneNewTapped = true
                            }
                        )
                        
                        createButton(
                            title: "Someone from my gift circle",
                            color: .pink,
                            imageName: "person.3.fill",
                            imageHeight: 150,
                            buttonHeight: 250,
                            action: {
                                isSomeoneFromGiftCircleTapped = true
                            }
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                } else if isSomeoneNewTapped {
                    // Second prompt after Gift Circle is selected
                    Text("Who are you shopping for?")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    VStack(spacing: 10) {
                        ForEach(relationships, id: \.self) { relationship in
                            createButton(
                                title: relationship,
                                action: {
                                    relationshipToUser = relationship
                                    answers = Array(repeating: "", count: prompts.count) // Initialize answers array
                                }
                            )
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    if relationshipToUser != "" {
                        Text("Tell me more about them.")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ForEach(prompts.indices, id: \.self) { index in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(prompts[index])
                                    .font(.headline)
                                    .foregroundColor(.black)
                                
                                if index < answers.count {
                                    TextField("Your answer", text: $answers[index])
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // And maybe a checkbox for 18+

                        // Submit button
                        createSubmitButton(title: "Submit", action: {
                            print("Submitted answers: \(answers)")
                            resetState() // Reset state to start over
                        })
                        .disabled(!allFieldsFilled()) // Disable if any field is empty
                        .padding(.horizontal)
                    }
                    
                    // Do gift generation thing here...
                } else if isSomeoneFromGiftCircleTapped {
                    Text("Who are you shopping for?")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top)
                    
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
        relationshipToUser = ""
        name = ""
        age = 0
        isSomeoneFromGiftCircleTapped = false
    }
    
    private func createButton(
        title: String,
        color: Color = Color("GiftedRedColor"),
        imageName: String? = nil,
        imageHeight: CGFloat = 30,
        buttonHeight: CGFloat = 60,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            VStack {
                if let imageName {
                    Image(systemName: imageName) // Replace with your custom logo if needed
                        .resizable()
                        .scaledToFit()
                        .frame(height: imageHeight)
                        .foregroundColor(.white)
                }
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame (height: buttonHeight, alignment: .center)
            .background(color)
            .cornerRadius(12)
        }
    }
    
    func createSubmitButton(
        title: String,
        color: Color = Color("GiftedRedColor"),
        buttonHeight: CGFloat = 60,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text("Submit")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(color)
                .cornerRadius(12)
        }
        .disabled(!allFieldsFilled()) // Disable if not all fields are filled
        .opacity(allFieldsFilled() ? 1.0 : 0.5) // Adjust opacity based on whether all fields are filled
    }
    
    private func allFieldsFilled() -> Bool {
        // Return true if all answers are non-empty
        return !answers.contains { $0.isEmpty }
    }
    
}


