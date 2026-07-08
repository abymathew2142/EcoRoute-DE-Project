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
    private let repository: CommuteRepositoryProtocol
    
    var totalRefund: Double {
        trips.reduce(0){ $0 + $1.taxRefundAmount}
    }
    

    // Depending on protocol, not the concrete implementation ( Dependency Inversion Principle )
    init(repository: CommuteRepositoryProtocol = CommuteRepository()) {
        self.repository = repository
    }
    
    
    func loadTrips() async {
        do {
            self.trips = try await repository.fetchAllTrips()
        }catch {
            print("Error loading entries : \(error)")
        }
    }
    
    func logNewTrip(distanceString: String, mode: TransportMode) async {
        
        guard let distanceDecimal = Double(distanceString) else { return }
        
        // fraud prevention
        // 1. absolute maximum commute within reasonalble German borders
        if distanceDecimal > Constants.maxCommuteDistance {
            print("Fraud alert : Commute distance is too high")
            return
        }
        
        //2. Bike physical limits
        if mode == .bike, distanceDecimal > Constants.minBikingDistance {
            print("Fraud alert : Biking distance is too high")
            return
        }
        
        let newTrip = CommuteTrip(id: UUID(),
                                  date: Date(),
                                  distance: distanceDecimal,
                                  transportMode: mode)
        
        do {
            try await repository.addTrip(newTrip)
            await loadTrips()
        }catch {
            print("Error saving entry : \(error)")
        }
    }
    
    
    func removeTrip(at offset: IndexSet) async {
        
        for index in offset {
            let trip = trips[index]
            do {
                try await repository.deleteTrip(trip)
            } catch {
                print("Error deleting entry : \(error)")
            }
        }
        await loadTrips()
        
    }
}
