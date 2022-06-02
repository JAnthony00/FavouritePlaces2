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
    
    //initialise the region for map.
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 1,
            longitude: 1),
        latitudinalMeters: 5000,
        longitudinalMeters: 5000
    )
    
    var body: some View {
        HStack {
            //update map coordinates.
            Button(action: {
                region.center.latitude = location.lat
                region.center.longitude = location.long
            }, label: {
                Image(systemName: "map")
            })
            //look for location coordinates based off location name - also updates sunrise and sunset times.
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
            //look up location name based off of coordinates. will try and use the most detailed found location name.
            Button(action: {
                print("looking up")
                //set newLocation as passable CLLocation object
                let newLocation = CLLocation(latitude: location.lat, longitude: location.long)
                location.lookupLocationName(for: newLocation )
            }, label: {
                Image(systemName: "text.magnifyingglass")
            })
            VStack {
                VStack {
                    //editable latitude bar
                    HStack {
                        Text("Lat: ")
                        TextField("Enter Latitude", text: $region.latitudeString)
                    }
                    //editable longitude bar
                    HStack {
                        Text("Lon: ")
                        TextField("Enter Longitude", text: $region.longitudeString)
                    }
                    //sunrise icon with time- based off of our timezone (so northern hemisphere times will be strange.
                    HStack {
                        HStack {
                            Image(systemName: "sunrise")
                            Text(sunriseSunset.sunrise) //eventually have local sunrise time
                        }
                        //sunset icon with time.
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
