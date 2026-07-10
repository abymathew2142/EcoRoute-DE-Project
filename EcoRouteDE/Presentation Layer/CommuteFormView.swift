//
//  ContentView.swift
//  EcoRoute DE
//
//  Created by Aby Mathew on 28/06/26.
//

import SwiftUI




struct CommuteFormView: View {
    
    @State private var viewModel = CommuteViewModel()
    @State private var distance: String = ""
    @State private var selectedTransportMode: TransportMode = .train
    @State private var locationManager = LocationManager()
    @FocusState private var isInputFocused: Bool
    private let modes = TransportMode.allCases
    
    
    
    var body: some View {
        NavigationStack {
            List {
                // ---- SECTION 1: TAX SUMMARY ---
                Section {
                    VStack(spacing: 8){
                        Text("Estimated German Tax Refund")
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                        Text(viewModel.totalRefund,
                             format: .currency(code: "EUR"))
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(.green)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
                .listRowBackground(Color(.systemGray6))
                
                
                // ---- SECTION 2: Input fields , Fraud-Proof tracking system ---
                Section(header: Text("Secure Commute Tracker")) {
        
                    Picker("Transport Mode", selection: $selectedTransportMode) {
                        ForEach(modes, id: \.self ) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                    .disabled(locationManager.isTracking) // Fraud Prevention: changing vehichle during tracking
                    
                    if !locationManager.isTracking {
                        // start tracking
                        Button(action: {
                            locationManager.startTracking()
                        }){
                            HStack{
                                Image(systemName: "play.fill")
                                Text("Start Live Commute")
                            }
                            .frame(maxWidth: .infinity)
                            .bold()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.blue)
                        
                    }else {
                        // stop tracking and save data automatically
                        Button(action: {
                            let calculatedDistanceInKM = locationManager.stopTracking()
                            Task {
                                await viewModel.logNewTrip(distanceString: "\(calculatedDistanceInKM)",
                                                           mode: selectedTransportMode)
                            }
                        }){
                            HStack{
                                Image(systemName: "stop.fill")
                                Text("End Live Commute")
                            }
                            .frame(maxWidth: .infinity)
                            .bold()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                    }
                    
                    //progressview adding while tracking start
                    if locationManager.isTracking {
                        HStack {
                            ProgressView()
                            Text("GPS Tracking active. Keep app open during travel...")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                // --- SECTION 3: RECENT COMMUTES (DYNAMIC LIST) ---
                
                Section(header: Text("Recent commutes \(viewModel.trips.count)")){
                    
                    if (viewModel.trips.isEmpty) {
                        Text("No commutes yet")
                            .foregroundStyle(.secondary)
                            .italic()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                        
                    }else {
                        
                        ForEach(viewModel.trips) { trip in
                            HStack {
                                Image(systemName: trip.transportMode.iconName)
                                    .foregroundColor(.accentColor)
                                    .font(.title)
                                    .frame(width: 30)
                                
                                VStack(alignment: .leading) {
                                    Text("\(trip.transportMode.rawValue.capitalized)")
                                        .font(.body)
                                        .bold()
                                    Text("\(trip.distance, specifier: "%.1f") km")
                                }
                                
                                Spacer()
                                
                                Text(trip.taxRefundAmount, format: .currency(code: "EUR"))
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.green)
                            }
                        }
                        .onDelete { indexSet in
                            Task {
                                await viewModel.removeTrip(at: indexSet)
                            }
                        }
                    }
                    
                }
            }
            .navigationTitle("EcoRoute DE")
            .task {
                await viewModel.loadTrips()
            }
        }
    }
}

#Preview {
    CommuteFormView()
}
