//
//  Movieuserdata+CoreDataProperties.swift
//  MovieReservation_4Team
//
//  Created by t2023-m0117 on 7/25/24.
//
//

import Foundation
import CoreData


extension Movieuserdata {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movieuserdata> {
        return NSFetchRequest<Movieuserdata>(entityName: "Movieuserdata")
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var id: String?
    @NSManaged public var password: String?
    @NSManaged public var userprofile: Data?

}

extension Movieuserdata : Identifiable {

}
