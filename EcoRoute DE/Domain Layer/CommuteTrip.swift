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
        case .car: return  "car.fill"
        case .bike: return "bicycle.fill"
        case .train: return "train.fill"
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
