//
//  LocationMapView.swift
//  FavouritePlaces
//
//  Created by Jack Brighton on 20/5/22.
//

import SwiftUI
import MapKit
import CoreLocation

struct LocationMapView: View {
    
    @ObservedObject var location: Location
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 1,
            longitude: 1),
        latitudinalMeters: 5000,
        longitudinalMeters: 5000
    )
    
    var body: some View {
        HStack {
            Button(action: {
                region.center.latitude = location.lat
                region.center.longitude = location.long
            }, label: {
                Image(systemName: "map")
            })
            Button(action: {
                print("looking up \(String(describing: location.name))")
                location.lookupCoordinates(for: location.name ?? "Brisbane")
                location.lookupSunriseSunset()
            }, label: {
                Image(systemName: "globe.europe.africa.fill")
            })
            Text(location.name ?? "")
        }
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.all)
        HStack {
            Button(action: {
                print("looking up")
                //expects a CLLocation
                //location.lookupLocationName(for:)
            }, label: {
                Image(systemName: "text.magnifyingglass")
            })
            VStack {
                VStack {
                    HStack {
                        Text("Lat: ")
                        TextField("Enter Latitude", text: $region.latitudeString)
                    }
                    HStack {
                        Text("Lon: ")
                        TextField("Enter Longitude", text: $region.longitudeString)
                    }
                    HStack {
                        HStack {
                            Image(systemName: "sunrise")
                            Text(sunriseSunset.sunrise) //eventually have local sunrise time
                        }
                        HStack {
                            Image(systemName: "sunset")
                            Text(sunriseSunset.sunset) //eventually have local sunset time
                        }
                    }
                }
            }
        }
    }
}

//struct LocationMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationMapView()
//    }
//}
