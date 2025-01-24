//
//  ButtonCreators.swift
//  GiftedApp
//
//  Created by Zach Stevens-Lindsey on 1/24/25.
//

import SwiftUI

func createVerticalButton(
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
                Image(systemName: imageName)
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
        .frame(height: buttonHeight, alignment: .center)
        .background(color)
        .cornerRadius(12)
    }
}

func createHorizontalButton(
    title: String,
    color: Color = Color("GiftedRedColor"),
    imageName: String? = nil,
    imageHeight: CGFloat = 30,
    buttonHeight: CGFloat = 60,
    action: @escaping () -> Void
) -> some View {
    Button(action: action) {
        HStack {
            if let imageName {
                Image(systemName: imageName)
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
        .frame(height: buttonHeight, alignment: .center)
        .background(color)
        .cornerRadius(12)
    }
}

func createSubmitButton(
    title: String,
    color: Color = Color("GiftedRedColor"),
    buttonHeight: CGFloat = 60,
    allFieldsFilled: @escaping () -> Bool,
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
