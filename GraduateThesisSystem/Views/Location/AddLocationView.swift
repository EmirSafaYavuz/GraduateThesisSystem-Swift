//
//  AddLocationView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 23.12.2023.
//

import SwiftUI

struct AddLocationView: View {
    @ObservedObject var viewModel: LocationViewModel
    @Binding var isPresented: Bool
    @State private var cityName = ""
    @State private var countryName = ""
    
    //Validation flag variables
    @State private var isCityNameValid = false
    @State private var isCountryNameValid = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Location")) {
                    TextField("City", text: $cityName)
                        .onChange(of: cityName) { oldValue, newValue in
                            isCityNameValid = !newValue.isEmpty
                        }
                        .autocapitalization(.words)
                    
                    TextField("Country", text: $countryName)
                        .onChange(of: countryName) { oldValue, newValue in
                            isCountryNameValid = !newValue.isEmpty
                        }
                        .autocapitalization(.words)
                }
            }
            .navigationTitle("Add Location")
            .toolbar {
               ToolbarItem(placement: .cancellationAction) {
                   Button("Dismiss") {
                       isPresented = false
                   }
               }
               ToolbarItem(placement: .confirmationAction) {
                   Button("Add") {
                       if(isCityNameValid && isCountryNameValid) {
                           let newLocation = Location(id: 0, city: cityName, country: countryName)
                           viewModel.addLocation(location: newLocation)
                           isPresented = false
                       }
                   }
                   .disabled(!isCityNameValid || !isCountryNameValid)
               }
           }
        }
    }
}

#Preview {
    AddLocationView(viewModel: LocationViewModel(), isPresented: .constant(true))
}
