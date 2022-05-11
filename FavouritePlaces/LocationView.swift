//
//  LocationView.swift
//  FavouritePlaces
//
//  Created by Jack Brighton on 11/5/22.
//

import SwiftUI

struct LocationView: View {
    
    @ObservedObject var location: Location
    @Environment(\.editMode) var editMode
    @State var locationName = ""
    @State var locationURL = ""
    @State var locationDesc = ""
    @State var locationLong = 0.0
    @State var locationLat = 0.0
    
    var body: some View {
        
        List {
            if editMode?.wrappedValue == .active {
                TextField("Enter location name", text: $locationName) {
                    $location.name.wrappedValue = locationName
                }
                TextField("Enter image URL", text: $locationURL) {
                    $location.urlString.wrappedValue = locationURL
                }
                TextField("Enter location description", text: $locationDesc) {
                    $location.desc.wrappedValue = locationDesc
                }
            } else {
                Text(location.locationName)
                Text(location.urlString)
                Text(location.desc ?? "")
            }
        }
        .navigationTitle("\(location.locationName)")
        .navigationBarItems(trailing: EditButton())
        
    }
}
