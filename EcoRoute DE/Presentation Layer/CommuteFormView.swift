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
                
                
                // ---- SECTION 2: Input fields ---
                Section(header: Text("Trip Details")) {
                    TextField("Distnace (in km)", text: $distance)
                        .keyboardType(.decimalPad)
                    
                    Picker("Transport Mode", selection: $selectedTransportMode) {
                        ForEach(modes, id: \.self ) {
                            Text($0.rawValue.capitalized)
                                
                        }
                    }
                }
                
                Button(action: {
                    Task {
                        await viewModel.logNewTrip(distanceString: distance,
                                                   mode: selectedTransportMode)
                        distance = ""
                    }
                    
                }) {
                    Text("Save Trip")
                        .frame(maxWidth: .infinity)
                        .alignmentGuide(.leading) { d in d[.leading] }
                }
                .buttonStyle(.borderedProminent)
                .disabled(distance.isEmpty)

                
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
