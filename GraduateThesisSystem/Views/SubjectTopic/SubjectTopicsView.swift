//
//  SubjectTopicsView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 23.12.2023.
//

import SwiftUI

struct SubjectTopicsView: View {
    @ObservedObject var viewModel = SubjectTopicViewModel()
    @State private var isAddSubjectTopicViewPresented = false
    
    var body: some View {
        List {
            ForEach(viewModel.subjectTopics) { subjectTopic in
                Text(subjectTopic.name)
            }
            .onDelete(perform: deleteSubjectTopic)
        }
        .onAppear {
            viewModel.getAllSubjectTopics()
        }
        .navigationTitle("Subject Topics")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isAddSubjectTopicViewPresented.toggle()
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isAddSubjectTopicViewPresented) {
                    AddSubjectTopicView(viewModel: viewModel, isPresented: $isAddSubjectTopicViewPresented)
                }
            }
        }
    }
    
    func deleteSubjectTopic(at offsets: IndexSet) {
        let subjectTopicIdToDelete = viewModel.subjectTopics[offsets.first ?? 0].id
        viewModel.deleteSubjectTopic(with: subjectTopicIdToDelete)
    }
}

#Preview {
    SubjectTopicsView()
}
