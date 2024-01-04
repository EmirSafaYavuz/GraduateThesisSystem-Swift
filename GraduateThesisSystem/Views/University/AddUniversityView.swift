//
//  AddUniversityView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import SwiftUI

struct AddUniversityView: View {
    @ObservedObject var viewModel: UniversityViewModel
    @Binding var isPresented: Bool
    @State private var universityName = ""
    @State private var selectedLocation = 0 // Varsayılan bir konum seçimi, 0 ya da uygun bir başlangıç değeri

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("University")) {
                    TextField("Name", text: $universityName)
                    Picker("Location", selection: $selectedLocation) {
                        ForEach(viewModel.locations, id: \.id) { location in
                            Text("\(location.city) / \(location.country)").tag(location.id)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
            }
            .onAppear {
                viewModel.getAllLocations()
            }
            .navigationTitle("Add University")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        if let selectedLocationObject = viewModel.locations.first(where: { $0.id == selectedLocation }) {
                            let newUniversity = UniversityInput(id: 0, name: universityName, locationId: selectedLocation)
                            viewModel.addUniversity(university: newUniversity)
                            isPresented = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddUniversityView(viewModel: UniversityViewModel(), isPresented: .constant(true))
}
