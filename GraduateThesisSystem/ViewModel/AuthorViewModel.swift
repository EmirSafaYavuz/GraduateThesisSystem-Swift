//
//  AuthorViewModel.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import Foundation

class AuthorViewModel: ObservableObject {
    @Published var authors: [Author] = []
    @Published var thesesOfAuthor: [Thesis] = []
    
    func getAllAuthors() {
        AuthorAPI.getAllAuthors { result in
            switch result {
            case .success(let fetchedAuthors):
                DispatchQueue.main.async {
                    self.authors = fetchedAuthors
                }
            case .failure(let error):
                print("Error loading authors: \(error)")
            }
        }
    }
    
    func getAuthor(with authorId: Int) {
        AuthorAPI.getAuthor(with: authorId) { result in
            switch result {
            case .success(let fetchedAuthor):
                DispatchQueue.main.async {
                    self.authors.append(fetchedAuthor)
                }
            case .failure(let error):
                print("Error loading author: \(error)")
            }
        }
    }
    
    func getThesesByAuthor(with authorId: Int) {
        AuthorAPI.getThesesByAuthor(with: authorId) { result in
            switch result {
            case .success(let fetchedTheses):
                DispatchQueue.main.async {
                    self.thesesOfAuthor = fetchedTheses
                }
            case .failure(let error):
                print("Error loading author's theses: \(error)")
            }
        }
    }

    func addAuthor(author: Author) {
        AuthorAPI.addAuthor(author: author) { result in
            switch result {
            case .success(let addedAuthor):
                DispatchQueue.main.async {
                    self.authors.append(addedAuthor)
                }
            case .failure(let error):
                print("Error adding author: \(error)")
            }
        }
    }
    
    func deleteAuthor(with authorId: Int?) {
        guard let authorId = authorId else {
            print("Author id is nil, cannot delete.")
            return
        }

        AuthorAPI.deleteAuthor(with: authorId) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.authors.removeAll { $0.id == authorId }
                }
            case .failure(let error):
                print("Error deleting author: \(error)")
            }
        }
    }

}
