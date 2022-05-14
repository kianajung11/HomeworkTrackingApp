//
//  FinalApp.swift
//  Shared
//
//  Created by Kiana Jung on 5/8/22.

// This is the Final App file where the content view is called

// Apoorva: To do assignment view, presentation slides, code structure
// Kiana: Profile view, calendar view, overall check on final code, live demo recording
// Lily: Navigation bar & icon code, presentation content, iOS principle/design heuristics


import SwiftUI

@main
struct FinalApp: App {
    var body: some Scene {
        let persistentContainer = PersistentController.shared
        WindowGroup {
            ContentView().environment(\.managedObjectContext,
                                       persistentContainer.container.viewContext)
        }
    }
}
