//
//  LocationViewModel.swift
//  FavouritePlaces
//
//  Created by Jack Brighton on 11/5/22.
//

import CoreData
import Foundation
import SwiftUI
import MapKit
import CoreLocation

fileprivate let defaultImage = Image(systemName: "map")
fileprivate var downloadedImages = [URL : Image]()
var sunriseSunset = SunriseSunset(sunrise: "unknown", sunset: "unknown")

extension Location {
    
    var locationName: String {
        get { name ?? "" }
        set {
            name = newValue
            save()
        }
    }
    
    var locationDesc: String {
        get { desc ?? "" }
        set {
            desc = newValue
            save()
        }
    }
    
//    var longitude: String {
//        get { String(long) }
//        set {
//            guard let longitude = Double(newValue) else { return }
//            long = longitude
//            save()
//        }
//    }
//
//    var latitude: String {
//        get { String(lat) }
//        set {
//            guard let latitude = Double(newValue) else { return }
//            lat = latitude
//            save()
//        }
//    }
    
    var urlString: String {
        get { imageURL?.absoluteString ?? "" }
        set {
            guard let url = URL(string: newValue) else { return }
            imageURL = url
            save()
        }
    }
    
    var sunrise: String {
        get { sunriseSunset.sunset }
        set { sunriseSunset.sunset = newValue }
    }
    
    var sunset: String {
        get { sunriseSunset.sunrise }
        set { sunriseSunset.sunrise = newValue }
    }
    
    func lookupCoordinates(for place: String) {
        //
        let coder = CLGeocoder()
        coder.geocodeAddressString(place) { optionalPlacemarks, optionalError in
            if let error = optionalError {
                print("Error looking up \(place): \(error.localizedDescription)")
                return
            }
            guard let placemarks = optionalPlacemarks, !placemarks.isEmpty else {
                print("Placemarks comes back empty")
                return
            }
            let placemark = placemarks[0]
            self.long = placemark.location?.coordinate.longitude ?? 1
            self.lat = placemark.location?.coordinate.latitude ?? 1
        }
    }
    
    func lookupLocationName(for point: CLLocation ) {
        //
        let coder = CLGeocoder()
        coder.reverseGeocodeLocation(point) { optionalPlacemarks, optionalError in
            if let error = optionalError {
                print("Error looking up \(point.coordinate): \(error.localizedDescription)")
                return
            }
            guard let placemarks = optionalPlacemarks, !placemarks.isEmpty else {
                print("Placemarks came back empty")
                return
            }
            let placemark = placemarks[0]
            for value in [
                \CLPlacemark.name,
                \.country,
                \.isoCountryCode,
                \.postalCode,
                \.administrativeArea,
                \.subAdministrativeArea,
                \.locality,
                \.subLocality,
                \.thoroughfare,
                \.subThoroughfare
            ] {
                print(String(describing: placemark[keyPath: value]))
            }
            self.name = placemark. subAdministrativeArea ?? placemark.locality ?? placemark.subLocality ?? placemark.name ?? placemark.thoroughfare ?? placemark.subThoroughfare ?? placemark.country ?? ""
        }
    }
    
    func lookupSunriseSunset() {
        //
    }
    
    func getImage() async -> Image {
        //has a proper url
        guard let url = imageURL else { return defaultImage }
        //check if image is already downloaded - if it is, just return the image
        if let image = downloadedImages[url] { return image }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            print("Downloaded \(response.expectedContentLength) bytes.")
            guard let uiImg = UIImage(data: data) else { return defaultImage }
            //image is image
            let image = Image(uiImage: uiImg).resizable()
            //store downloaded image
            downloadedImages[url] = image
            return image
        } catch {
            print("Error downloading \(url): \(error.localizedDescription)")
        }
        return defaultImage
    }
    
    @discardableResult
    func save() -> Bool {
        do {
            try managedObjectContext?.save()
        } catch {
            print("Error saving: \(error)")
            return false
        }
        return true
    }
}

//trying to have these coordinates work with the entity coordinates.
//these currently work with the map.
extension MKCoordinateRegion {
    var longitudeString: String {
        get { "\(center.longitude)" }
        set {
            guard let degrees = CLLocationDegrees(newValue) else { return }
            center.longitude = degrees
        }
    }
    
    var latitudeString: String {
        get { "\(center.latitude)" }
        set {
            guard let degrees = CLLocationDegrees(newValue) else { return }
            center.latitude = degrees
        }
    }
}
