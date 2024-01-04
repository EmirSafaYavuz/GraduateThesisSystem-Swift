//
//  AddLanguageView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 23.12.2023.
//

import SwiftUI

struct AddLanguageView: View {
    @ObservedObject var viewModel: LanguageViewModel
    @Binding var isPresented: Bool
    @State private var languageName = ""
    
    //Validation flag variables
    @State private var isNameValid = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Language")) {
                    TextField("Name", text: $languageName)
                        .onChange(of: languageName) { oldValue, newValue in
                            isNameValid = !newValue.isEmpty
                        }
                }
            }
            .navigationTitle("Add Language")
            .toolbar {
               ToolbarItem(placement: .cancellationAction) {
                   Button("Dismiss") {
                       isPresented = false
                   }
               }
               ToolbarItem(placement: .confirmationAction) {
                   Button("Add") {
                       if(isNameValid) {
                           let newLanguage = Language(id: 0, name: languageName)
                           viewModel.addLanguage(language: newLanguage)
                           isPresented = false
                       }
                   }
                   .disabled(!isNameValid)
               }
           }
        }
    }
}

#Preview {
    AddLanguageView(viewModel: LanguageViewModel(), isPresented: .constant(true))
}
