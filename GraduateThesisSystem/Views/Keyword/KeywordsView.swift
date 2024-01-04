//
//  KeywordsView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 27.12.2023.
//

import SwiftUI

struct KeywordsView: View {
    @ObservedObject var viewModel = KeywordViewModel()
    @State private var isAddKeywordViewPresented = false
    
    var body: some View {
        List {
            ForEach(viewModel.keywords) { keyword in
                NavigationLink(destination: KeywordDetailView(keyword: keyword)) {
                    Text(keyword.name)
                }
            }
            .onDelete(perform: deleteKeyword)
        }
        .onAppear {
            viewModel.getAllKeywords()
        }
        .navigationTitle("Keywords")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isAddKeywordViewPresented.toggle()
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isAddKeywordViewPresented) {
                    AddKeywordView(viewModel: viewModel, isPresented: $isAddKeywordViewPresented)
                }
            }
        }
    }
    
    func deleteKeyword(at offsets: IndexSet) {
        let keywordIdToDelete = viewModel.keywords[offsets.first ?? 0].id
        viewModel.deleteKeyword(with: keywordIdToDelete)
    }
}

#Preview {
    KeywordsView()
}
