//
//  AddSubjectTopicView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 23.12.2023.
//

import SwiftUI

struct AddSubjectTopicView: View {
    @ObservedObject var viewModel: SubjectTopicViewModel
    @Binding var isPresented: Bool
    @State private var subjectTopicName = ""
    
    //Validation flag variables
    @State private var isNameValid = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Subject Topic")) {
                    TextField("Name", text: $subjectTopicName)
                        .onChange(of: subjectTopicName) { oldValue, newValue in
                            isNameValid = !newValue.isEmpty
                        }
                        .autocapitalization(.words)
                }
            }
            .navigationTitle("Add Subject Topic")
            .toolbar {
               ToolbarItem(placement: .cancellationAction) {
                   Button("Dismiss") {
                       isPresented = false
                   }
               }
               ToolbarItem(placement: .confirmationAction) {
                   Button("Add") {
                       if(isNameValid) {
                           let newSubjectTopic = SubjectTopic(id: 0, name: subjectTopicName)
                           viewModel.addSubjectTopic(subjectTopic: newSubjectTopic)
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
    AddSubjectTopicView(viewModel: SubjectTopicViewModel(), isPresented: .constant(true))
}
