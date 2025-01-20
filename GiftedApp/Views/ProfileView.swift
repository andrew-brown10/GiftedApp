//
//  ProfileView.swift
//  GiftedApp
//
//  Created by Zach Stevens-Lindsey on 1/19/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authHelper: AuthHelper

    var body: some View {
        VStack() {
            Text("User Id: \($authHelper.userId.wrappedValue)")
                .font(.title)
                
                
            Button("Sign Out") {
                authHelper.signOut()
            }
        }
    }
}
