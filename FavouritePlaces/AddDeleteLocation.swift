//
//  AddDeleteLocation.swift
//  FavouritePlaces
//
//  Created by Jack Brighton on 2/6/22.
//

import Foundation

private func addLocation() {
    withAnimation {
        let newLocation = Location(context: viewContext)
        newLocation.name = "Location"

        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}


