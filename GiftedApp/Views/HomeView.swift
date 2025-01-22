//
//  HomeView.swift
//  GiftedApp
//
//  Created by Zach Stevens-Lindsey on 12/15/24.
//

import SwiftUI

struct HomeView: View {
    // State Variables
    @State private var isSomeoneNewTapped = false
    @State private var relationshipToUser = ""
    @State private var answers: [String: String] = [:] // Store answers as a dictionary
    // Input for numeric fields
    @State private var numericAnswer: Int? = nil
    @State private var rangeAnswer: (min: Int?, max: Int?) = (nil, nil)
    // Focus for prompts
    @FocusState private var focusedField: Int?
    // New gift recipient state
    @State private var name = ""
    @State private var age: Int = 0
    @State private var occasion = ""
    @State private var hobbies = ""
    @State private var priceRange: ClosedRange<Int> = 0...0
    
    // Gift circle state
    @State private var isSomeoneFromGiftCircleTapped = false
    
    // Auto scroll
    @State private var scrollTrigger = UUID() // Unique identifier to force scrolling
    
    // Array of relationship options
    let relationships = ["Significant other", "Child", "Parent", "Sibling", "Friend", "Colleague", "Other"]
    
    // Prompts with field types (e.g., text, number, range)
    let promptsWithTypes: [(prompt: String, fieldType: FieldType, placeholder: String)] = [
        ("What's their name?", .text, "Name"),
        ("How old are they?", .number, "Age"),
        ("What's the occasion?", .text, "Birthday, housewarming party..."),
        ("What hobbies or activities do they enjoy?", .text, "Biking, reading..."),
        ("What's your price range?", .range, ""),
    ]
    
    enum FieldType {
        case text
        case number
        case range
    }
    
    var body: some View {
        ScrollViewReader { proxy in
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
                                    color: relationshipToUser.isEmpty || relationshipToUser == relationship
                                    ? Color("GiftedRedColor")
                                    : Color("GiftedRedColor").opacity(0.5),
                                    action: {
                                        relationshipToUser = relationship
                                        answers = [:] // Clear previous answers
                                        // Force the scroll by updating `scrollTrigger`
                                        scrollTrigger = UUID()
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
                                .id("PromptsSection")
                            
                            ForEach(promptsWithTypes.indices, id: \.self) { index in
                                let prompt = promptsWithTypes[index].prompt
                                let fieldType = promptsWithTypes[index].fieldType
                                let placeholder = promptsWithTypes[index].placeholder
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(prompt)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    
                                    switch fieldType {
                                    case .text:
                                        TextField(placeholder, text: Binding(
                                            get: { answers[prompt] ?? "" },
                                            set: { answers[prompt] = $0 }
                                        ))
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .focused($focusedField, equals: index)
                                        .onSubmit {
                                            moveToNextField(currentField: index)
                                        }
                                        
                                    case .number:
                                        TextField(placeholder, text: Binding(
                                            get: { numericAnswer != nil ? String(numericAnswer!) : "" },
                                            set: { numericAnswer = Int($0) }
                                        ))
                                        .keyboardType(.numberPad)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .focused($focusedField, equals: index)
                                        .onSubmit {
                                            moveToNextField(currentField: index)
                                        }
                                        
                                    case .range:
                                        HStack {
                                            Text("$")
                                            TextField("Min", text: Binding(
                                                get: { rangeAnswer.min != nil ? String(rangeAnswer.min!) : "" },
                                                set: { rangeAnswer.min = Int($0) }
                                            ))
                                            .keyboardType(.numberPad)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .frame(maxWidth: 60)
                                            .frame(maxWidth: 60)
                                            .focused($focusedField, equals: index)
                                            .onSubmit {
                                                moveToNextField(currentField: index)
                                            }
                                            Text("-")
                                            Text("$")
                                            TextField("Max", text: Binding(
                                                get: { rangeAnswer.max != nil ? String(rangeAnswer.max!) : "" },
                                                set: { rangeAnswer.max = Int($0) }
                                            ))
                                            .keyboardType(.numberPad)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .frame(maxWidth: 60)
                                            .focused($focusedField, equals: index)
                                            .onSubmit {
                                                moveToNextField(currentField: index)
                                            }

                                        }
                                    }
                                    // And maybe a checkbox for 18+
                                }
                                .padding(.horizontal)
                            }
                            
                            // Submit button
                            createSubmitButton(title: "Submit", action: {
                                collectDataFromAnswers()  // Collect data from answers before resetting state
                                resetState() // Reset state to start over
                            })
                            .disabled(!allFieldsFilled()) // Disable if any field is empty
                            .padding(.horizontal)
                        }
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
                .onChange(of: scrollTrigger) {
                    // Scroll to the prompts section whenever `scrollTrigger` changes
                    withAnimation {
                        proxy.scrollTo("PromptsSection", anchor: .top)
                    }
                }
            }
            .onAppear {
                // Reset the state when the view appears
                resetState()
            }
        }
    }
    
    private func moveToNextField(currentField: Int) {
        let nextField = currentField + 1
        if nextField < promptsWithTypes.count {
            focusedField = nextField
        }
    }
    
    private func allFieldsFilled() -> Bool {
        // Check if all answers in the dictionary are filled
        let allAnswersFilled = !answers.values.contains { $0.isEmpty }

        // Check if numericAnswer and rangeAnswer are filled and valid
        let isNumericAnswerFilled = numericAnswer != nil
        let isRangeAnswerFilled = rangeAnswer.min != nil && rangeAnswer.max != nil && (rangeAnswer.min! < rangeAnswer.max!)

        // Return true if all fields are filled
        return allAnswersFilled && isNumericAnswerFilled && isRangeAnswerFilled
    }
    
    private func updateAnswers(_ value: String, for prompt: String) {
        answers[prompt] = value
    }
    
    func collectDataFromAnswers() -> GiftRecipientData {
        // Parse range input
        let priceRange = (rangeAnswer.min != nil && rangeAnswer.max != nil) ? rangeAnswer.min!...rangeAnswer.max! : 0...0
        
        let collectedData = GiftRecipientData(
            name: name,
            age: age,
            occasion: occasion,
            hobbies: hobbies,
            priceRange: priceRange // Now passing a ClosedRange<Int>
        )
        
        return collectedData
    }
    
    private func resetState() {
        isSomeoneNewTapped = false
        relationshipToUser = ""
        name = ""
        age = 0
        occasion = ""
        hobbies = ""
        priceRange = 0...0
        isSomeoneFromGiftCircleTapped = false
        rangeAnswer = (nil, nil)
        numericAnswer = nil
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
        .disabled(!allFieldsFilled())
        .opacity(allFieldsFilled() ? 1.0 : 0.5) // Adjust opacity based on whether all fields are filled
    }
}
