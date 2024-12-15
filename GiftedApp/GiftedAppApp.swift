//
//  GiftedAppApp.swift
//  GiftedApp
//
//  Created by Andrew Brown on 12/14/24.
//  Made goated by Zach Stevens-Lindsey on 12/15/24.
//

import SwiftUI
import SwiftData

@main
struct GiftedAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
