//
//  CommuteViewModel.swift
//  EcoRoute DE
//
//  Created by Aby Mathew on 29/06/26.
//

import Foundation
import Observation


@Observable
class CommuteViewModel {
    
    var trips: [CommuteTrip] = []
    
    var totalRefund: Double {
        trips.reduce(0){ $0 + $1.taxRefundAmount}
    }
    
    func logNewTrip(distanceString: String, mode: TransportMode) {
        
        guard let distanceDecimal = Double(distanceString) else { return }
        
        let newTrip = CommuteTrip(date: Date(),
                                  distance: distanceDecimal,
                                  transportMode: mode)
        
        trips.append(newTrip)
    }
}
