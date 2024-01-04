//
//  LocationsView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 23.12.2023.
//

import SwiftUI

struct LocationsView: View {
    @ObservedObject var viewModel = LocationViewModel()
    @State private var isAddLocationViewPresented = false
    
    var body: some View {
        List {
            ForEach(viewModel.locations) { location in
                VStack(alignment: .leading) {
                    Text(location.city)
                        .font(.headline)
                    Text(location.country)
                }
            }
            .onDelete(perform: deleteLocation)
        }
        .onAppear {
            viewModel.getAllLocations()
        }
        .navigationTitle("Locations")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isAddLocationViewPresented.toggle()
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isAddLocationViewPresented) {
                    AddLocationView(viewModel: viewModel, isPresented: $isAddLocationViewPresented)
                }
            }
        }
    }
    
    func deleteLocation(at offsets: IndexSet) {
        let locationIdToDelete = viewModel.locations[offsets.first ?? 0].id
        viewModel.deleteLocation(with: locationIdToDelete)
    }
}

#Preview {
    LocationsView()
}
