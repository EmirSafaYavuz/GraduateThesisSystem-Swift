//
//  AuthorDetailView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import SwiftUI

struct AuthorsView: View {
    @ObservedObject var viewModel = AuthorViewModel()
    @State private var isAddAuthorViewPresented = false

    var body: some View {
        List {
            ForEach(viewModel.authors) { author in
                Label(author.name, systemImage: "person")
            }
        }
        .onAppear {
            viewModel.getAllAuthors()
        }
        .navigationTitle("Authors")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isAddAuthorViewPresented.toggle()
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isAddAuthorViewPresented) {
                    AddAuthorView(viewModel: viewModel, isPresented: $isAddAuthorViewPresented)
                }
            }
        }
    }
}

#Preview {
    AuthorsView()
}
