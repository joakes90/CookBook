//
//  Cook_BookApp.swift
//  Cook Book
//
//  Created by Justin Oakes on 1/27/25.
//

import SwiftUI
import SwiftData

@main
struct Cook_BookApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ImageCache.self,
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
            RecipesView()
        }
        .modelContainer(sharedModelContainer)
    }
}
