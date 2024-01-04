//
//  LanguagesView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 23.12.2023.
//

import SwiftUI

struct LanguagesView: View {
    @ObservedObject var viewModel = LanguageViewModel()
    @State private var isAddLanguageViewPresented = false
    
    var body: some View {
        List {
            ForEach(viewModel.languages) { language in
                Text(language.name)
            }
            .onDelete(perform: deleteLanguage)
        }
        .onAppear {
            viewModel.getAllLanguages()
        }
        .navigationTitle("Languages")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isAddLanguageViewPresented.toggle()
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isAddLanguageViewPresented) {
                    AddLanguageView(viewModel: viewModel, isPresented: $isAddLanguageViewPresented)
                }
            }
        }
    }
    
    func deleteLanguage(at offsets: IndexSet) {
        let languageIdToDelete = viewModel.languages[offsets.first ?? 0].id
        viewModel.deleteLanguage(with: languageIdToDelete)
    }
}

#Preview {
    LanguagesView()
}
