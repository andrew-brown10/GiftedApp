//
//  GiftedAppApp.swift
//  GiftedApp
//
//  Created by Andrew Brown on 12/14/24.
//  Made goated by Zach Stevens-Lindsey on 12/15/24.
//

import SwiftUI
import SwiftData
import Firebase

@main
struct GiftedAppApp: App {
    @StateObject private var authObject = AuthHelper()
    @StateObject private var userSlice = UserSlice()// Create the shared instance

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        FirebaseApp.configure()
        
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(authObject)
                .environmentObject(userSlice)
        }
        .modelContainer(sharedModelContainer)
    }
}
