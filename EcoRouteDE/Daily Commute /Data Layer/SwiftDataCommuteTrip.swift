//
//  SwiftDataCommuteTrip.swift
//  EcoRoute DE
//
//  Created by Aby Mathew on 05/07/26.
//

import Foundation
import SwiftData

@Model class SwiftDataCommuteTrip {
    @Attribute(.unique) var id: UUID
    var date: Date
    var distance: Double
    var tranportMode: String
    var isSynced: Bool

    init(id: UUID = UUID(), date: Date = Date(), distance: Double, tranportMode: String, isSynced: Bool = false) {
        self.id = id
        self.date = date
        self.distance = distance
        self.tranportMode = tranportMode
        self.isSynced = isSynced
    }
    
    func toDomain() -> CommuteTrip {
        CommuteTrip(id: id, date: date, distance: distance, transportMode: TransportMode(rawValue: tranportMode) ?? .bike)
    }
    
}
