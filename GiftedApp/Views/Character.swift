//
//  SwiftUIView.swift
//  GiftedApp
//
//  Created by Andrew Brown on 12/14/24.
//

import SwiftUI

struct Character: View {
    @State private var user: Person?

    var body: some View {
        HStack{
            Circle().onTapGesture {
                Task{
                    await getNewCharacter()
                }
            }
            Text("Name:\(user?.name ?? "Loading...")")
            Text("Relationship:\(user?.relation ?? "Loading...")")
            Text("Descripition:\(user?.description ?? "Loading...")")
        }
        .task {
            do {
                user = try await GiftedClient.shared.getCharacter()
            } catch {
                user = nil
            }
        }
    }
    
    private func getNewCharacter() async {
        do{
            user = try await GiftedClient.shared.getCharacter()
        } catch {
            user = nil
        }
    }
}
