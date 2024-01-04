//
//  ThesisDetailView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import SwiftUI

struct ThesesView: View {
    @ObservedObject var viewModel = ThesisViewModel()
    @State private var isAddThesisViewPresented = false
    
    var body: some View {
        List {
            ForEach(viewModel.theses) { thesis in
                NavigationLink(destination: ThesisDetailView(thesis: thesis)) {
                    ThesisCard(title: thesis.title, author: String(thesis.authorName), thesisNo: String(thesis.thesisNo), thesisType: thesis.thesisType)
                }
            }
            .onDelete(perform: deleteThesis)
        }
        .refreshable {
            viewModel.getAllTheses()
        }
        .onAppear {
            viewModel.getAllTheses()
        }
        .navigationTitle("Theses")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isAddThesisViewPresented.toggle()
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isAddThesisViewPresented) {
                    AddThesisView(viewModel: viewModel, isPresented: $isAddThesisViewPresented)
                }
            }
        }
    }
    
    func deleteThesis(at offsets: IndexSet) {
        let thesisIdToDelete = viewModel.theses[offsets.first ?? 0].id
        viewModel.deleteThesis(with: thesisIdToDelete)
    }
}

#Preview {
    ThesesView()
}
