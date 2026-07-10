//
//  CommuteRepository.swift
//  EcoRoute DE
//
//  Created by Aby Mathew on 05/07/26.
//

import Foundation
import SwiftData

final class CommuteRepository : CommuteRepositoryProtocol {
    
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    init() {
        do {
            self.modelContainer = try ModelContainer(for: SwiftDataCommuteTrip.self)
            self.modelContext = modelContainer.mainContext
            
        }catch {
            fatalError("Failed to initialize model container: \(error.localizedDescription)")
        }
    }
    
    
    func fetchAllTrips() async throws -> [CommuteTrip] {
        let descriptor = FetchDescriptor<SwiftDataCommuteTrip>(sortBy: [SortDescriptor(\.date, order: .reverse)])
        let trips = try modelContext.fetch(descriptor)
        return trips.map{ $0.toDomain() }
        
    }
    
    func addTrip(_ trip: CommuteTrip) async throws {
        let dpTrip = SwiftDataCommuteTrip(date: trip.date,
                                          distance: trip.distance,
                                          tranportMode: trip.transportMode.rawValue)
        modelContext.insert(dpTrip)
        try modelContext.save()
    }
    
    func deleteTrip(_ trip: CommuteTrip) async throws {
        let tripId = trip.id
        let descriptor = FetchDescriptor<SwiftDataCommuteTrip>(predicate: #Predicate{ $0.id == tripId })
        if let tripToDelete = try modelContext.fetch(descriptor).first {
            modelContext.delete(tripToDelete)
            try modelContext.save()
        }
        
    }
    
    
}
