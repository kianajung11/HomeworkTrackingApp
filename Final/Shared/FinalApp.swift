//
//  FinalApp.swift
//  Shared
//
//  Created by Kiana Jung on 5/8/22.
//

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
