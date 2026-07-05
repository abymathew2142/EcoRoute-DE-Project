//
//  CommuteTrip.swift
//  EcoRoute DE
//
//  Created by Aby Mathew on 28/06/26.
//

import Foundation

struct CommuteTrip: Identifiable {
    let id: UUID
    let date: Date
    let distance: Double
    let transportMode: TransportMode
    
    var taxRefundAmount: Double {
        return distance * 0.3
    }
}
