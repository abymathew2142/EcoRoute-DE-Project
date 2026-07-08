//
//  MockCommuteRepository.swift
//  EcoRoute DETests
//
//  Created by Aby Mathew on 07/07/26.
//

import Foundation

final class MockCommuteRepository : CommuteRepositoryProtocol {
    var stubbedTrips: [CommuteTrip] = []
    
    var didCallFetchAllTrips = false
    var didCallAddTrip = false
    var didCallDeleteTrip = false
    
 
    
    func fetchAllTrips() async throws -> [CommuteTrip] {
        didCallFetchAllTrips = true
        return stubbedTrips
    }
    
    
    func addTrip(_ trip: CommuteTrip) async throws {
        didCallAddTrip = true
        stubbedTrips.append(trip)
    }
    
    
    func deleteTrip(_ trip: CommuteTrip) async throws {
        didCallDeleteTrip = true
        stubbedTrips.removeAll(where: { $0.id == trip.id })
    }
    
    
}
