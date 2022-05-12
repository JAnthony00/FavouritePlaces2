//
//  ContentView.swift
//  FavouritePlaces
//
//  Created by Jack Brighton on 10/5/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Location.name, ascending: false)],
        animation: .default)
    private var locations: FetchedResults<Location>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(locations) { location in
                    NavigationLink {
                        LocationView(location: location)
                    } label: {
                        LocationRowView(location: location)
                    }
                }
                .onDelete(perform: deleteLocations)
            }
            .navigationTitle("Favourite Places")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: addLocation) {
                Label("New Location", systemImage: "plus")
            })
            Text("Select a Location")
        }
    }

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

    private func deleteLocations(offsets: IndexSet) {
        withAnimation {
            offsets.map { locations[$0] }.forEach(viewContext.delete)

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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
