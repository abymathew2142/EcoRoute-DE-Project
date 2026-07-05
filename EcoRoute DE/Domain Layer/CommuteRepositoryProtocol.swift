//
//  CommuteRepositoryProtocol.swift
//  EcoRoute DE
//


import Foundation

protocol CommuteRepositoryProtocol: AnyObject { // Repository Abstraction Interface
    
    func fetchAllTrips() async throws -> [CommuteTrip]
    func addTrip(_ trip: CommuteTrip) async throws
    func deleteTrip(_ trip: CommuteTrip) async throws
}
