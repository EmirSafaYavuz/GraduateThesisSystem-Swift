//
//  InstitutesView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 22.12.2023.
//

import SwiftUI

struct InstitutesView: View {
    @ObservedObject var viewModel = InstituteViewModel()
    @State private var isAddInstituteViewPresented = false
    
    var body: some View {
        List {
            ForEach(viewModel.institutes) { institute in
                NavigationLink(destination: InstituteDetailView(institute: institute)) {
                    VStack(alignment: .leading) {
                        Text(institute.name)
                            .font(.headline)
                        Text(institute.universityName)
                    }
                }
            }
            .onDelete(perform: deleteInstitute)
        }
        .onAppear {
            viewModel.getAllInstitutes()
        }
        .navigationTitle("Institutes")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isAddInstituteViewPresented.toggle()
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isAddInstituteViewPresented) {
                    AddInstituteView(viewModel: viewModel, isPresented: $isAddInstituteViewPresented)
                }
            }
        }
    }
    
    func deleteInstitute(at offsets: IndexSet) {
        let instituteIdToDelete = viewModel.institutes[offsets.first ?? 0].id
        viewModel.deleteInstitute(with: instituteIdToDelete)
    }
}

#Preview {
    InstitutesView()
}
