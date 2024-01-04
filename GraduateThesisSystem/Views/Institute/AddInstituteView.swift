//
//  AddInstituteView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 22.12.2023.
//

import SwiftUI

struct AddInstituteView: View {
    @ObservedObject var viewModel: InstituteViewModel
    @Binding var isPresented: Bool
    @State private var instituteName = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Institute")) {
                    TextField("Name", text: $instituteName)
                }
            }
            .navigationTitle("Add Institute")
            .toolbar {
               ToolbarItem(placement: .cancellationAction) {
                   Button("Dismiss") {
                       isPresented = false
                   }
               }
               ToolbarItem(placement: .confirmationAction) {
                   Button("Add") {
                       let newInstitute = Institute(id: 0, name: instituteName, universityId: 0, universityName: "String")
                       viewModel.addInstitute(institute: newInstitute)
                       isPresented = false
                   }
               }
           }
        }
    }
}

#Preview {
    AddInstituteView(viewModel: InstituteViewModel(), isPresented: .constant(true))
}
