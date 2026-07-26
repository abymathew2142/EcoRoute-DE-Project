//
//  OfflineFirstCommuteRepository.swift
//  EcoRouteDE
//
//  Created by Aby Mathew on 26/07/26.
//

import Foundation
import SwiftData
//import SwiftUI

final class OfflineFirstCommuteRepository: CommuteRepositoryProtocol {
    
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
    
    // basic CRUD operations
    func fetchAllTrips() async throws -> [CommuteTrip] {
        let descriptor = FetchDescriptor<SwiftDataCommuteTrip>(sortBy: [SortDescriptor(\.date, order: .reverse)])
        let trips = try modelContext.fetch(descriptor)
        return trips.map{ $0.toDomain() }
    }
    
    func addTrip(_ trip: CommuteTrip) async throws {
        let dbTrip = SwiftDataCommuteTrip(id: trip.id, distance: trip.distance, tranportMode: trip.transportMode.rawValue, isSynced: false)
                modelContext.insert(dbTrip)
                try modelContext.save()
                
                // 2. Fire and forget an explicit sync action in the background
                Task {
                    await syncPendingTripsToCloud()
                }
    }
    
    func syncPendingTripsToCloud() async {
            let descriptor = FetchDescriptor<SwiftDataCommuteTrip>(predicate: #Predicate { $0.isSynced == false })
            
            guard let pendingTrips = try? modelContext.fetch(descriptor) else { return }
            
            for localTrip in pendingTrips {
                do {
                    //CODE: using networkService save the localtrip model into Romote Server/Database
                    print("Network SYNC done for trip: \(localTrip.id)")
                    
                    // If success, flip flag to true and save local state
                    localTrip.isSynced = true
                    try modelContext.save()
                } catch {
                    print("Network unreachable. Will retry syncing automatically later on.")
                    break // Stop sync queue execution loop until next trigger interval
                }
            }
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
