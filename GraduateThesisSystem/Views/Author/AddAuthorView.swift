//
//  AddAuthorView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import SwiftUI

struct AddAuthorView: View {
    @ObservedObject var viewModel: AuthorViewModel
    @Binding var isPresented: Bool
    @State private var authorName = ""
    @State private var authorEmail = ""

    // Validation flag variables
    @State private var isNameValid = false
    @State private var isEmailValid = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Author")) {
                    TextField("Name", text: $authorName)
                        .onChange(of: authorName, { oldValue, newValue in
                            // Validate name (non-empty)
                            isNameValid = !newValue.isEmpty
                        })
                        .autocapitalization(.words)

                    TextField("Email", text: $authorEmail)
                        .onChange(of: authorEmail, { oldValue, newValue in
                            // Validate email (non-empty and valid format)
                            isEmailValid = isValidEmail(newValue)
                        })
                        .textInputAutocapitalization(.never)
                        .autocapitalization(.none)
                }
            }
            .navigationTitle("Add Author")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        // Check if both name and email are valid before adding
                        if isNameValid && isEmailValid {
                            let newAuthor = Author(id: 0, name: authorName, email: authorEmail)
                            viewModel.addAuthor(author: newAuthor)
                            isPresented = false
                        }
                    }
                    .disabled(!isNameValid || !isEmailValid)
                }
            }
        }
    }

    // Basic email validation function
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}


#Preview {
    AddAuthorView(viewModel: AuthorViewModel(), isPresented: .constant(true))
}
