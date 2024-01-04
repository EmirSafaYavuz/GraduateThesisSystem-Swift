//
//  AddKeywordView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 27.12.2023.
//

import SwiftUI

struct AddKeywordView: View {
    @ObservedObject var viewModel: KeywordViewModel
    @Binding var isPresented: Bool
    @State private var keywordName = ""
    
    //Validation flag variables
    @State private var isNameValid = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Keyword")) {
                    TextField("Name", text: $keywordName)
                        .onChange(of: keywordName) { oldValue, newValue in
                            isNameValid = !newValue.isEmpty
                        }
                        .autocapitalization(.words)
                }
            }
            .navigationTitle("Add Keyword")
            .toolbar {
               ToolbarItem(placement: .cancellationAction) {
                   Button("Dismiss") {
                       isPresented = false
                   }
               }
               ToolbarItem(placement: .confirmationAction) {
                   Button("Add") {
                       if(isNameValid) {
                           let newKeyword = Keyword(id: 0, name: keywordName)
                           viewModel.addKeyword(keyword: newKeyword)
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
    AddKeywordView(viewModel: KeywordViewModel(), isPresented: .constant(true))
}
