//
//  ContentView.swift
//  EcoRoute DE
//
//  Created by Aby Mathew on 28/06/26.
//

import SwiftUI

enum TransportMode: String, CaseIterable, Identifiable {
    case car = "car"
    case bike = "bike"
    case train = "train"
    
    var id: Self { self }
}


struct CommuteFormView: View {
    
    @State private var distance: String = ""
    @State private var transportMode: TransportMode = .train
    private let modes = TransportMode.allCases
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Trip Details")) {
                    TextField("Distnace (in km)", text: $distance)
                        .keyboardType(.decimalPad)
                    
                    Picker("Transport Mode", selection: $transportMode) {
                        ForEach(modes, id: \.self ) {
                            Text($0.rawValue.capitalized)
                                
                        }
                    }
                }
                
                Button(action: {
                    print("Saving trip: \(distance) km by \(transportMode.rawValue.capitalized)")
                }) {
                    Text("Save Trip")
                        .frame(maxWidth: .infinity)
                        .alignmentGuide(.leading) { d in d[.leading] }
                }
                .buttonStyle(.borderedProminent)

            }
            .navigationTitle("Log my commute")
        }
    }
}

#Preview {
    CommuteFormView()
}
