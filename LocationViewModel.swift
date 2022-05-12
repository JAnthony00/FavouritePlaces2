//
//  LocationViewModel.swift
//  FavouritePlaces
//
//  Created by Jack Brighton on 11/5/22.
//

import CoreData
import Foundation
import SwiftUI

fileprivate let defaultImage = Image(systemName: "map")
fileprivate var downloadedImages = [URL : Image]()

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
