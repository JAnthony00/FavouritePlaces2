//
//  LocationViewModel.swift
//  FavouritePlaces
//
//  Created by Jack Brighton on 11/5/22.
//

import CoreData
import Foundation
import SwiftUI

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
    
    var urlString: String {
        get { imageURL?.absoluteString ?? "" }
        set {
            guard let url = URL(string: newValue) else { return }
            imageURL = url
            save()
        }
    }
    
    var longitude: String {
        get { String(long) }
        set {
            guard let longitude = Double(newValue) else { return }
            long = longitude
            save()
        }
    }
    
    var latitude: String {
        get { String(lat) }
        set {
            guard let latitude = Double(newValue) else { return }
            lat = latitude
            save()
        }
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
