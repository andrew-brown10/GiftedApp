//
//  SwiftUIView.swift
//  GiftedApp
//
//  Created by Andrew Brown on 12/14/24.
//

import SwiftUI


struct SwiftUIView: View {
    @State private var text: String = "Hello, World!"

    var body: some View {
        HStack{
            Circle().onTapGesture {
                makeLeft()
            }
            Circle().onTapGesture {
                makeRight()
            }
        }
        Text("\(text)")
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
