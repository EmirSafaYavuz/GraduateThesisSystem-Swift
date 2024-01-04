//
//  SupervisorsView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 23.12.2023.
//

import SwiftUI

struct SupervisorsView: View {
    @ObservedObject var viewModel = SupervisorViewModel()
    @State private var isAddSupervisorViewPresented = false
    
    var body: some View {
        List {
            ForEach(viewModel.supervisors) { supervisor in
                NavigationLink(destination: SupervisorDetailView(supervisor: supervisor)) {
                    VStack(alignment: .leading) {
                        Text(supervisor.name)
                            .font(.headline)
                        Text(supervisor.phoneNumber)
                        
                    }
                }
            }
            .onDelete(perform: deleteSupervisor)
        }
        .onAppear {
            viewModel.getAllSupervisors()
        }
        .navigationTitle("Supervisors")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isAddSupervisorViewPresented.toggle()
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isAddSupervisorViewPresented) {
                    AddSupervisorView(viewModel: viewModel, isPresented: $isAddSupervisorViewPresented)
                }
            }
        }
    }
    
    func deleteSupervisor(at offsets: IndexSet) {
        let supervisorIdToDelete = viewModel.supervisors[offsets.first ?? 0].id
        viewModel.deleteSupervisor(with: supervisorIdToDelete)
    }
}

#Preview {
    SupervisorsView()
}
