//
//  SwiftUIView.swift
//  GiftedApp
//
//  Created by Andrew Brown on 12/14/24.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var text: String = "Hello, World!"
    @State private var user: Person?

    var body: some View {
        HStack{
            Circle().onTapGesture {
                makeLeft()
            }
            Circle().onTapGesture {
                makeRight()
            }
            Text("\(text)")
        }
        .task {
            do {
                user = try await GiftedClient.shared.getCharacter()
                text = user?.Description ?? "No description"
            } catch {
                user = nil
                text = "Error with API"
            }
        }
    }
    
    private func makeLeft() {
        text = "Left"
    }
    
    private func makeRight() {
        text = "Right"
    }
}

#Preview {
    SwiftUIView()
}
