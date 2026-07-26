//
//  CommutePDFView.swift
//  EcoRouteDE
//
//  Created by Aby Mathew on 26/07/26.
//

import SwiftUI

struct CommutePDFView: View {
    
    let trips: [CommuteTrip]
    let totalRefund: Double
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            // pdf header
            HStack {
                VStack(alignment: .leading) {
                    Text("EcoRoute DE - Tax Report")
                        .font(.title)
                        .bold()
                    Text("Official Commute Log for Finanzamt")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
//                Spacer()
//                Text("🇩🇪")
//                    .font(.largeTitle)
            }
            
            Divider()
            
            //---- summary card ---
            HStack {
                Text("Total Verified Trips: \(trips.count)")
                Spacer()
                Text("Total Tax Refund: \(totalRefund, format: .currency(code: "EUR"))")
                    .bold()
                    .foregroundColor(.blue)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            
            // --- TABLE OF TRIPS ---
            Text("Logged Commutes")
                .font(.headline)
                .padding(.top)
            
            VStack(alignment: .leading, spacing: 10) {
                // Table Header
                HStack {
                    Text("Date").bold().frame(width: 100, alignment: .leading)
                    Text("Mode").bold().frame(width: 80, alignment: .leading)
                    Text("Distance").bold().frame(width: 100, alignment: .leading)
                    Spacer()
                    Text("Refund").bold()
                }
                .font(.caption)
                .foregroundColor(.secondary)
                
                Divider()
                
                // Table Rows
                ForEach(trips) { trip in
                    HStack {
                        Text(trip.date.formatted(date: .abbreviated, time: .omitted))
                            .frame(width: 100, alignment: .leading)
                        Text(trip.transportMode.rawValue)
                            .frame(width: 80, alignment: .leading)
                        Text("\(trip.distance, specifier: "%.2f") km")
                            .frame(width: 100, alignment: .leading)
                        Spacer()
                        Text(trip.taxRefundAmount, format: .currency(code: "EUR"))
                    }
                    .font(.footnote)
                    Divider()
                }
        }
            
            Spacer()
            
            // --- SECURITY NOTE & FRAUD PREVENTION FOOTER ---
            // നമ്മൾ മുൻപ് സംസാരിച്ച ഫ്രോഡ് പ്രിവൻഷൻ ഇവിടെ എഴുതി വെക്കുന്നത് ജർമ്മൻ ഓഡിറ്റർമാർക്ക് ഇഷ്ടപ്പെടും
            VStack(alignment: .leading, spacing: 5) {
                HStack{
                    Image(systemName: "lock.shield")
                    Text("Hardware Verified Report")
                        .font(.caption)
                        .bold()
                }
               
                Text("All entries in this document were automatically locked and verified using iPhone GPS CoreLocation hardware metrics. Manual altering is restricted.")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            .padding(.top)
        }
        .padding(40)
        .frame(width: 595, height: 842)
    }
}

