//
//  SupervisorDetailView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 26.12.2023.
//

import SwiftUI

struct SupervisorDetailView: View {
    @ObservedObject var viewModel = SupervisorViewModel()
    var supervisor: Supervisor
    var body: some View {
        Form {
            Section(header: Text("Supervisor Information")) {
                Text("Name: \(supervisor.name)")
                Text("Phone Number: \(supervisor.phoneNumber)")
            }

            Section(header: Text("Theses supervised by")) {
                ForEach(viewModel.thesesOfSupervisor) { thesis in
                    NavigationLink(destination: ThesisDetailView(thesis: thesis)) {
                        Text(thesis.title)
                    }
                }
            }
        }
        .onAppear() {
            viewModel.getThesesBySupervisor(with: supervisor.id)
        }
        .navigationTitle(supervisor.name)
    }
}

#Preview {
    SupervisorDetailView(supervisor: Supervisor(id: 0, name: "Emir Safa", phoneNumber: "05321234567"))
}
