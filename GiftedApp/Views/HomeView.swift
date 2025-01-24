//
//  HomeView.swift
//  GiftedApp
//
//  Created by Zach Stevens-Lindsey on 12/15/24.
//

import SwiftUI

struct Prompt {
    let prompt: String
    let fieldType: FieldType
    let placeholder: String
}

enum FieldType {
    case text
    case number
    case range
}

struct HomeView: View {
    // State Variables
    @State private var isSomeoneNewTapped = false
    @State private var relationshipToUser = ""
    @State private var answers: [String: String] = [:] // Store answers as a dictionary
    // Input for numeric fields
    @State private var numericAnswer: Int? = nil
    @State private var rangeAnswer: (min: Int?, max: Int?) = (nil, nil)
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
    let promptsWithTypes: [Prompt] = [
        Prompt(prompt: "What's their name?", fieldType: .text, placeholder: "Name"),
        Prompt(prompt: "How old are they?", fieldType: .number, placeholder: "Age"),
        Prompt(prompt: "What's the occasion?", fieldType: .text, placeholder: "Birthday, housewarming party..."),
        Prompt(prompt: "What hobbies or activities do they enjoy?", fieldType: .text, placeholder: "Biking, reading..."),
        Prompt(prompt: "What's your price range?", fieldType: .range, placeholder: "")
    ]
    
    @ViewBuilder
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if !isSomeoneNewTapped && !isSomeoneFromGiftCircleTapped {
                        SomeoneNewOrGiftCircleView(
                            createVerticalButton: createVerticalButton as! (String, Color, String?, CGFloat, CGFloat, @escaping () -> Void) -> AnyView,
                            isSomeoneNewTapped: $isSomeoneNewTapped,
                            isSomeoneFromGiftCircleTapped: $isSomeoneFromGiftCircleTapped
                        )
                    } else if isSomeoneNewTapped {
                        // Second prompt after Gift Circle is selected
                        SomeoneNewView(
                            relationshipToUser: $relationshipToUser,
                            answers: $answers,
                            numericAnswer: $numericAnswer,
                            rangeAnswer: $rangeAnswer,
                            scrollTrigger: $scrollTrigger,
                            relationships: relationships,
                            promptsWithTypes: promptsWithTypes,
                            resetState: resetState, // Ensure this is passed in correctly
                            allFieldsFilled: allFieldsFilled, // Ensure this is passed in correctly
                            // Binding parameters:
                            name: $name, // Pass the Binding to the name
                            age: $age, // Pass the Binding to the age
                            occasion: $occasion, // Pass the Binding to the occasion
                            hobbies: $hobbies, // Pass the Binding to the hobbies
                            priceRange: $priceRange, // Pass the Binding to the priceRange
                            createVerticalButton: createVerticalButton as! (String, Color, String?, CGFloat, CGFloat, @escaping () -> Void) -> AnyView,
                            createSubmitButton: createSubmitButton as! (String, Color, CGFloat, @escaping () -> Bool, @escaping () -> Void) -> AnyView
                        )
                    } else if isSomeoneFromGiftCircleTapped {
                        Text("Who are you shopping for?")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.top)
                        GiftCircleView()
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
    
    private func resetState() {
        print("Resetting state!")
        isSomeoneNewTapped = false
        isSomeoneFromGiftCircleTapped = false
        relationshipToUser = ""
        name = ""
        age = 0
        occasion = ""
        hobbies = ""
        priceRange = 0...0
        rangeAnswer = (nil, nil)
        numericAnswer = nil
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
    
}


struct SomeoneNewOrGiftCircleView: View {
    let createVerticalButton: (
        String,
        Color,
        String?,
        CGFloat,
        CGFloat,
        @escaping () -> Void
    ) -> AnyView
    @Binding var isSomeoneNewTapped: Bool
    @Binding var isSomeoneFromGiftCircleTapped: Bool
    
    var body: some View {
        Text("Who are you shopping for?")
            .font(.title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading) // Left align the text
            .padding(.horizontal)
            .padding(.top)
        
        VStack(spacing: 10) {
            createVerticalButton(
                "Someone new",
                Color("GiftedRedColor"),
                "person.badge.plus",
                150,
                250,
                {
                    isSomeoneNewTapped = true
                }
            )
            createVerticalButton(
                "Someone from my gift circle",
                .pink,
                "person.3.fill",
                150,
                250,
                {
                    isSomeoneFromGiftCircleTapped = true
                }
            )
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}


struct SomeoneNewView: View {
    @Binding var relationshipToUser: String
    @Binding var answers: [String: String]
    @Binding var numericAnswer: Int?
    @Binding var rangeAnswer: (min: Int?, max: Int?)
    @Binding var scrollTrigger: UUID
    
    let relationships: [String]
    var promptsWithTypes: [Prompt]
    var resetState: () -> Void // Declare it as a function type
    let allFieldsFilled: () -> Bool
    
    // New gift recipient state
    @Binding var name: String
    @Binding var age: Int
    @Binding var occasion: String
    @Binding var hobbies: String
    @Binding var priceRange: ClosedRange<Int>
    
    let createVerticalButton: (
        String,
        Color,
        String?,
        CGFloat,
        CGFloat,
        @escaping () -> Void
    ) -> AnyView
    var createSubmitButton: (String, Color, CGFloat, @escaping () -> Bool, @escaping () -> Void) -> AnyView
    
    // Focus for prompts
    @FocusState private var focusedField: Int?
    
    var body: some View {
        VStack(spacing: 10){
            // Second prompt after Gift Circle is selected
            Text("Who are you shopping for?")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top)
            
            VStack(spacing: 10) {
                ForEach(relationships, id: \.self) { relationship in
                    createVerticalButton(
                        relationship,
                        relationshipToUser.isEmpty || relationshipToUser == relationship ? Color("GiftedRedColor") : Color("GiftedRedColor").opacity(0.5),
                        nil,
                        30, // Default image height
                        60, // Default button height
                        {
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
                VStack (alignment: .leading, spacing: 10) {
                    Text("Tell me more about them.")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .id("PromptsSection")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(promptsWithTypes, id: \.prompt) { promptWithType in
                        let prompt = promptWithType.prompt
                        let fieldType = promptWithType.fieldType
                        let placeholder = promptWithType.placeholder
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(prompt)
                                .font(.headline)
                                .foregroundColor(.black)
                            
                            switch fieldType {
                            case .text:
                                TextField(
                                    placeholder,
                                    text: Binding(
                                        get: { answers[prompt] ?? "" },
                                        set: { answers[prompt] = $0 }
                                    )
                                )
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .focused($focusedField, equals: promptsWithTypes.firstIndex(where: { $0.prompt == prompt }))
                                .onSubmit {
                                    moveToNextField(currentField: promptsWithTypes.firstIndex(where: { $0.prompt == prompt }) ?? 0)
                                }
                                
                            case .number:
                                TextField(
                                    placeholder,
                                    text: Binding(
                                        get: { numericAnswer != nil ? String(numericAnswer!) : "" },
                                        set: { numericAnswer = Int($0) }
                                    )
                                )
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .focused($focusedField, equals: promptsWithTypes.firstIndex(where: { $0.prompt == prompt }))
                                .onSubmit {
                                    moveToNextField(currentField: promptsWithTypes.firstIndex(where: { $0.prompt == prompt }) ?? 0)
                                }
                                
                            case .range:
                                HStack {
                                    Text("$")
                                    TextField(
                                        "Min",
                                        text: Binding(
                                            get: { rangeAnswer.min != nil ? String(rangeAnswer.min!) : "" },
                                            set: { rangeAnswer.min = Int($0) }
                                        )
                                    )
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(maxWidth: 60)
                                    .focused($focusedField, equals: promptsWithTypes.firstIndex(where: { $0.prompt == prompt }))
                                    .onSubmit {
                                        moveToNextField(currentField: promptsWithTypes.firstIndex(where: { $0.prompt == prompt }) ?? 0)
                                    }
                                    Text("-")
                                    Text("$")
                                    TextField(
                                        "Max",
                                        text: Binding(
                                            get: { rangeAnswer.max != nil ? String(rangeAnswer.max!) : "" },
                                            set: { rangeAnswer.max = Int($0) }
                                        )
                                    )
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(maxWidth: 60)
                                    .focused($focusedField, equals: promptsWithTypes.firstIndex(where: { $0.prompt == prompt }))
                                    .onSubmit {
                                        moveToNextField(currentField: promptsWithTypes.firstIndex(where: { $0.prompt == prompt }) ?? 0)
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .frame(alignment: .leading)
                
                // Submit button
                createSubmitButton(
                    "Submit",
                    Color("GiftedRedColor"),
                    60,
                    allFieldsFilled,
                    {
                        collectDataFromAnswers()  // Collect data from answers before resetting state
                        resetState() // Reset state to start over
                    })
                .disabled(!allFieldsFilled()) // Disable if any field is empty
                .padding(.horizontal)
            }
        }
        .toolbar {
            toolbarContent(for: focusedField ?? 0)
        }
    }
    
    private func moveToNextField(currentField: Int) {
        let nextField = currentField + 1
        if nextField < promptsWithTypes.count {
            focusedField = nextField
        }
    }
    
    func collectDataFromAnswers() -> GiftRecipientData {
        // Parse range input
        let priceRange = (rangeAnswer.min != nil && rangeAnswer.max != nil) ? rangeAnswer.min!...rangeAnswer.max! : 0...0
        
        let collectedData = GiftRecipientData(
            relationshipToUser: relationshipToUser,
            name: name,
            age: age,
            occasion: occasion,
            hobbies: hobbies,
            priceRange: priceRange // Now passing a ClosedRange<Int>
        )
        
        return collectedData
    }
    
    // Function to return toolbar content dynamically
    @ToolbarContentBuilder
    private func toolbarContent(for currentIndex: Int) -> some ToolbarContent {
        ToolbarItemGroup(placement: .keyboard) {
            Button("Previous") {
                if currentIndex > 0 { focusedField = currentIndex - 1 }
            }
            .disabled(currentIndex == 0)
            
            Button("Next") {
                if currentIndex < promptsWithTypes.count - 1 {
                    focusedField = currentIndex + 1
                }
            }
            .disabled(currentIndex == promptsWithTypes.count - 1)
            
            Spacer()
            
            Button("Done") {
                focusedField = nil
            }
        }
    }
    
}
