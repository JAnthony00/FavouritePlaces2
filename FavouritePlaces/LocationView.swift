//
//  LocationView.swift
//  FavouritePlaces
//
//  Created by Jack Brighton on 11/5/22.
//

import SwiftUI

struct LocationView: View {
    
    @Environment(\.editMode) var editMode
    @State var locationName = ""
    @State var locationURL = ""
    @State var locationDesc = ""
    @State var locationLong = 0.0
    @State var locationLat = 0.0
    
    
    var body: some View {
        
        List {
            if editMode?.wrappedValue == .active {
                TextField("Enter location name", text: $locationName)
                TextField("Enter image URL", text: $locationURL)
                TextField("Enter location description", text: $locationDesc)
            } else {
                Text(locationName)
                Text(locationURL)
                Text(locationDesc)
            }
        }
        .navigationTitle("location")
        .navigationBarItems(trailing: EditButton())
        
    }
}
