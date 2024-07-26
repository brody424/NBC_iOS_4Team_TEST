//
//  UserData+CoreDataProperties.swift
//  MovieReservation_4Team
//
//  Created by t2023-m0117 on 7/25/24.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var id: String?
    @NSManaged public var password: String?
    @NSManaged public var userprofile: Data?

}

extension UserData : Identifiable {

}
