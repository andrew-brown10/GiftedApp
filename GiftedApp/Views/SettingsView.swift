//
//  SettingsView.swift
//  GiftedApp
//
//  Created by Zach Stevens-Lindsey on 1/19/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authHelper: AuthHelper
    
    var body: some View {
        Button("Sign Out") {
            authHelper.signOut()
        }
    }
}
