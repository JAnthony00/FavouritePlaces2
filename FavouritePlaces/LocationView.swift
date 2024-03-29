//
//  LocationView.swift
//  FavouritePlaces
//
//  Created by Jack Brighton on 11/5/22.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @ObservedObject var location: Location
    @Environment(\.editMode) var editMode
    @State var locationName = ""
    @State var locationURL = ""
    @State var locationDesc = ""
    @State var locationLong = 0.0
    @State var locationLat = 0.0
    @State var image = Image(systemName: "map")
    
    var body: some View {
        //list showing location name, URL, description, longitude and latitude which is all editable in a textfield.
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
                TextField("Enter location Longitude", value: $locationLong, formatter: formatter ) {
                    $location.long.wrappedValue = locationLong
                }
                TextField("Enter location Latitude", value: $locationLat, formatter: formatter) {
                    $location.lat.wrappedValue = locationLat
                }
                //shows a plain list - defaults are: name- "location", desc- "", long- 0, lat- 0.
            } else {
                Text(location.locationName)
                Text(location.desc ?? "")
                NavigationLink("Map of \(location.name ?? "Location") ", destination: LocationMapView(location: location))
                Text("Longitude: \(location.long)")
                Text("Latitude: \(location.lat)")
                image.aspectRatio(contentMode: .fit)
            }
        }
        .navigationTitle("\(location.locationName)")
        .navigationBarItems(trailing: EditButton())
        .task {
            image = await location.getImage()
        }
    }
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
