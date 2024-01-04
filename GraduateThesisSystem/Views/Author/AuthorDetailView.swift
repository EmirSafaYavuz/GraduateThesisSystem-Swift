//
//  AuthorDetailView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 26.12.2023.
//

import SwiftUI

struct AuthorDetailView: View {
    @ObservedObject var viewModel = AuthorViewModel()
    var author: Author
    var body: some View {
        Form {
            Section(header: Text("Author Information")) {
                Text("Name: \(author.name)")
                Text("Email: \(author.email)")
            }

            Section(header: Text("Theses")) {
                ForEach(viewModel.thesesOfAuthor) { thesis in
                    NavigationLink(destination: ThesisDetailView(thesis: thesis)) {
                        Text(thesis.title)
                    }
                }
            }
        }
        .onAppear {
            viewModel.getThesesByAuthor(with: author.id)
        }
        .navigationTitle(author.name)
    }
}

#Preview {
    AuthorDetailView(author: Author(id: 0, name: "Emir Safa", email: "emirsafayavuz@gmail.com"))
}
