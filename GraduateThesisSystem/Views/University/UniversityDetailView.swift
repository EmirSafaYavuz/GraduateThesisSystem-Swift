//
//  UniversityDetailView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 26.12.2023.
//

import SwiftUI

struct UniversityDetailView: View {
    @ObservedObject var viewModel = UniversityViewModel()
    var university: University
    var body: some View {
        Form {
            Section(header: Text("University Information")) {
                Text("Name: \(university.name)")
                Text("City: \(university.city)")
                Text("Country: \(university.country)")
            }
            
            Section(header: Text("Institutes")) {
                ForEach(viewModel.institutesOfUniversity, id: \.id) { institute in
                    NavigationLink(destination: InstituteDetailView(institute: institute)) {
                        Text(institute.name)
                    }
                }
            }
        }
        .onAppear {
            viewModel.getInstitutes(by: university.id)
        }
        .navigationTitle(university.name)
    }
}

#Preview {
    UniversityDetailView(university: University(id: 0, name: "Maltepe University", locationId: 0, city: "İstanbul", country: "Turkey"))
}
