//
//  FavouritePlacesApp.swift
//  FavouritePlaces
//
//  Created by Jack Brighton on 10/5/22.
//

import SwiftUI

@main
struct FavouritePlacesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
