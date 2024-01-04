//
//  AddSupervisorView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 23.12.2023.
//

import SwiftUI

struct AddSupervisorView: View {
    @ObservedObject var viewModel: SupervisorViewModel
    @Binding var isPresented: Bool
    @State private var supervisorName = ""
    @State private var phoneNumber = ""
    
    //Validation flag variables
    @State private var isNameValid = false
    @State private var isPhoneNumberValid = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Supervisor")) {
                    TextField("Name", text: $supervisorName)
                        .onChange(of: supervisorName) { oldValue, newValue in
                            isNameValid = !newValue.isEmpty
                        }
                        .autocapitalization(.words)
                    
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.numberPad) // Klavyeyi sadece sayılar için ayarla
                        .onChange(of: phoneNumber) { oldValue, newValue in
                            // Girilen metin sadece sayılar ve boşluk karakteri içeriyorsa izin ver
                            isPhoneNumberValid = newValue.isEmpty || newValue.rangeOfCharacter(from: CharacterSet.decimalDigits.union(CharacterSet.whitespaces)) != nil
                        }
                        .autocapitalization(.none)

                }
            }
            .navigationTitle("Add Supervisor")
            .toolbar {
               ToolbarItem(placement: .cancellationAction) {
                   Button("Dismiss") {
                       isPresented = false
                   }
               }
               ToolbarItem(placement: .confirmationAction) {
                   Button("Add") {
                       if isNameValid && isPhoneNumberValid {
                           let newSupervisor = Supervisor(id: 0, name: supervisorName, phoneNumber: phoneNumber)
                           viewModel.addSupervisor(supervisor: newSupervisor)
                           isPresented = false
                       }
                   }
                   .disabled(!isNameValid || !isPhoneNumberValid)
               }
           }
        }
    }
}

#Preview {
    AddSupervisorView(viewModel: SupervisorViewModel(), isPresented: .constant(true))
}
