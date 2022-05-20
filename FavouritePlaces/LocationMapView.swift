//
//  LocationMapView.swift
//  FavouritePlaces
//
//  Created by Jack Brighton on 20/5/22.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    
    @ObservedObject var location: Location
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: -27.47,
            longitude: 153.02),
            latitudinalMeters: 5000,
            longitudinalMeters: 5000
    )
    
    var body: some View {
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.all)
        HStack {
            Text("Lat: ")
            TextField("Enter Latitude", text: $region.latitudeString)
        }
        HStack {
            Text("Lon: ")
            TextField("Enter Longitude", text: $region.longitudeString)
        }
    }
}

//struct LocationMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationMapView()
//    }
//}
