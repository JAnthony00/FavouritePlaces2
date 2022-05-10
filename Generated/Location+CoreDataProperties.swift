//
//  Location+CoreDataProperties.swift
//  FavouritePlaces
//
//  Created by Jack Brighton on 10/5/22.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var url: URL?
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var lat: Double
    @NSManaged public var long: Double

}

extension Location : Identifiable {

}
