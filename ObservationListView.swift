//
//  ObservationListView.swift
//  SkyJournal
//
//  Created by Elliott on 30/5/2025.
//


import SwiftUI

struct ObservationListView: View {
    @EnvironmentObject var viewModel: ObservationViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.observations) { observation in
                    VStack(alignment: .leading) {
                        Text(observation.title)
                            .font(.headline)
                        Text(observation.date, style: .date)
                            .font(.subheadline)
                    }
                }
                .onDelete(perform: viewModel.deleteObservation)
            }
            .navigationTitle("SkyJournal")
            .toolbar {
                NavigationLink(destination: AddObservationView()) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
