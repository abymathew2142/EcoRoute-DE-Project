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

    init(id: UUID = UUID(), date: Date, distance: Double, tranportMode: String) {
        self.id = id
        self.date = date
        self.distance = distance
        self.tranportMode = tranportMode
    }
    
    func toDomain() -> CommuteTrip {
        CommuteTrip(id: id, date: date, distance: distance, transportMode: TransportMode(rawValue: tranportMode) ?? .bike)
    }
    
}
