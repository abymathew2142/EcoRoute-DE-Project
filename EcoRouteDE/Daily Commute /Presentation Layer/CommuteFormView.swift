//
//  ContentView.swift
//  EcoRoute DE
//
//  Created by Aby Mathew on 28/06/26.
//

import SwiftUI

/*
struct ContentView: View {
    @State var viewModel = CommuteViewModel()
    @State private var locationManager = LocationManager()
    @State private var selectedMode: TransportMode = .train
    let modes = ["Train", "Car", "Bike"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Subtle semantic background gradient matching professional finance apps
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        heroCard
                        controlPanel
                        dynamicHistoryList
                    }
                    .padding(16)
                }
            }
            .navigationTitle("EcoRoute DE")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.loadTrips()
            }
        }
    }
}

private extension ContentView {
    var heroCard: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("ESTIMATED TAX REFUND")
                        .font(.system(.caption, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                        .tracking(1.5)
                    
                    Text(viewModel.totalRefund, format: .currency(code: "EUR"))
                        .font(.system(size: 42, weight: .black, design: .rounded))
                        .foregroundColor(.primary)
                }
                Spacer()
                
                // Clean interactive status indicator
                Image(systemName: "checkmark.shield.fill")
                    .font(.title)
                    .foregroundColor(.green)
                    .padding(12)
                    .background(Color.green.opacity(0.1))
                    .clipShape(Circle())
            }
            
            Divider()
                .padding(.vertical, 4)
            
            // Micro-data summary rows
            HStack {
                Label("\(viewModel.trips.count) Logs", systemImage: "tray.full.fill")
                Spacer()
                Label("GPS Secured", systemImage: "location.fill")
            }
            .font(.footnote)
            .foregroundColor(.secondary)
        }
        .padding(24)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 5)
    }
    
    var controlPanel: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("SECURE TRACKER")
                .font(.system(.caption, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .tracking(1.5)
            
            // Minimal modern segment picker
            Picker("Mode", selection: $selectedMode) {
                ForEach(modes, id: \.self) { mode in
                    Text(mode)
                }
            }
            .pickerStyle(.segmented)
            .disabled(locationManager.isTracking)
            
            if !locationManager.isTracking {
                Button(action: {
                    locationManager.startTracking()
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "play.fill")
                        Text("Start Live Commute")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(Color.accentColor)
                    .cornerRadius(14)
                }
            } else {
                Button(action: {
                    let calculatedDistance = locationManager.stopTracking()
                    Task {
                        await viewModel.logNewTrip(distanceString: "\(calculatedDistance)",
                                                   mode: selectedMode)
                    }
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "stop.fill")
                        Text("End Commute & Save")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(Color.red)
                    .cornerRadius(14)
                }
                
                // Live pulse animation layout placeholder
                HStack {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 8, height: 8)
                    Text("Hardware GPS verification active...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 2)
            }
        }
        .padding(20)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 5)
    }
    
    var dynamicHistoryList: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("VERIFIED RECENT HISTORY")
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .tracking(1.5)
                Spacer()
                
                // Native PDF trigger integrated quietly into the architecture flow
                if !viewModel.trips.isEmpty {
                    ShareLink(item:  URL(fileURLWithPath: "")) {
                        Label("Export PDF", systemImage: "doc.text.fill")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                }
            }
            
            if viewModel.trips.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "location.slash.fill")
                        .font(.largeTitle)
                        .foregroundColor(.secondary.opacity(0.5))
                    Text("No hardware logs registered yet.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                .background(Color(.secondarySystemGroupedBackground))
                .cornerRadius(16)
            } else {
                VStack(spacing: 0) {
                    ForEach(viewModel.trips) { trip in
                        HStack(spacing: 16) {
                            // Dynamic vector icons mapping transport variants
                            Image(systemName:  "car.fill" )
                                .font(.headline)
                                .foregroundColor(.accentColor)
                                .frame(width: 44, height: 44)
                                .background(Color.accentColor.opacity(0.08))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(trip.transportMode.rawValue)
                                    .font(.body)
                                    .fontWeight(.semibold)
                                Text("\(trip.distance, specifier: "%.2f") km • Hardware Verified")
                                    .font(.caption)
                                    .foregroundColor(.green)
                            }
                            
                            Spacer()
                            
                            Text(trip.taxRefundAmount, format: .currency(code: "EUR"))
                                .font(.body)
                                .fontWeight(.bold)
                        }
                        .padding(.vertical, 14)
                        
                        // Custom divider exclusion bounds rule handling
                        if trip.id != viewModel.trips.last?.id {
                            Divider()
                        }
                    }
                }
                .padding(.horizontal, 16)
                .background(Color(.secondarySystemGroupedBackground))
                .cornerRadius(20)
            }
        }
    }
}

*/
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
