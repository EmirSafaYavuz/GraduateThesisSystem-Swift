//
//  UniversityDetailView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import SwiftUI

struct UniversitiesView: View {
    @ObservedObject var viewModel = UniversityViewModel()
    @State private var isAddUniversityViewPresented = false
    
    var body: some View {
        List {
            ForEach(viewModel.universities) { university in
                NavigationLink(destination: UniversityDetailView(university: university)) {
                    VStack(alignment: .leading) {
                        Text(university.name)
                            .font(.headline)
                        Text("\(university.city) / \(university.country)")
                    }
                }
            }
            .onDelete(perform: deleteUniversity)
        }
        .onAppear {
            viewModel.getAllUniversities()
        }
        .navigationTitle("Universities")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isAddUniversityViewPresented.toggle()
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isAddUniversityViewPresented) {
                    AddUniversityView(viewModel: viewModel, isPresented: $isAddUniversityViewPresented)
                }
            }
        }
    }
    
    func deleteUniversity(at offsets: IndexSet) {
        let universityIdToDelete = viewModel.universities[offsets.first ?? 0].id
        viewModel.deleteUniversity(with: universityIdToDelete)
    }
}

#Preview {
    UniversitiesView()
}
