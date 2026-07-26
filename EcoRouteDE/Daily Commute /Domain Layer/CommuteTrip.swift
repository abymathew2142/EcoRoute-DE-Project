//
//  CommuteTrip.swift
//  EcoRoute DE
//
//  Created by Aby Mathew on 28/06/26.
//

import Foundation

enum TransportMode: String, CaseIterable, Identifiable {
    case car = "car"
    case bike = "bike"
    case train = "train"
    
    var iconName: String {
        switch self {
        case .car: return  "car.circle.fill"
        case .bike: return "bicycle.circle.fill"
        case .train: return "tram.circle.fill"
        }
    }
    
    var id: Self { self }
}

struct CommuteTrip: Identifiable {
    let id: UUID
    let date: Date
    let distance: Double
    let transportMode: TransportMode
    
    var taxRefundAmount: Double {
        return distance * 0.3
    }
}
