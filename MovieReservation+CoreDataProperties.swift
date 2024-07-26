//
//  MovieReservation+CoreDataProperties.swift
//  MovieReservation_4Team
//
//  Created by t2023-m0023 on 7/26/24.
//
//

import Foundation
import CoreData


extension Reservation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reservation> {
        return NSFetchRequest<Reservation>(entityName: "Reservation")
    }

    @NSManaged public var date: Date?
    @NSManaged public var movieID: String?
    @NSManaged public var quantity: Int32
    @NSManaged public var reservationID: UUID?
    @NSManaged public var user: UserData?

}

extension MovieReservation : Identifiable {

}
