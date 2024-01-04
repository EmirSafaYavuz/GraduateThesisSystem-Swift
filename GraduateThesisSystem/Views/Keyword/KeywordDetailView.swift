//
//  KeywordDetailView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 27.12.2023.
//

import SwiftUI

struct KeywordDetailView: View {
    @ObservedObject var viewModel = KeywordViewModel()
    var keyword: Keyword
    
    var body: some View {
        Form {
            Section(header: Text("Keyword Information")) {
                Text("Name: \(keyword.name)")
            }
            
            Section(header: Text("Theses of keyword")) {
                ForEach(viewModel.thesesOfKeyword) { thesis in
                    NavigationLink(destination: ThesisDetailView(thesis: thesis)) {
                        Text(thesis.title)
                    }
                }
            }
        }
        .onAppear() {
            viewModel.getThesesKeywords(with: keyword.id)
        }
        .navigationTitle(keyword.name)
    }
}

#Preview {
    KeywordDetailView(keyword: Keyword(id: 0, name: "Swift"))
}
