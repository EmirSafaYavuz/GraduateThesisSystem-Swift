//
//  EditThesisView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 25.12.2023.
//

import SwiftUI

struct EditThesisView: View {
    @Binding var thesis: Thesis
    @Binding var isPresented: Bool
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Thesis Details")) {
                    TextField("Title", text: $thesis.title)
                    TextEditor(text: $thesis.abstract)
                    // Add more fields as needed
                }
            }
            .navigationTitle("Edit Thesis")
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                },
                trailing: Button("Save") {
                    // Save the changes and dismiss the sheet
                    isPresented = false
                }
            )
        }
    }
}
