//
//  InstituteDetailView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 26.12.2023.
//

import SwiftUI

struct InstituteDetailView: View {
    var institute: Institute
    var body: some View {
        Form {
            Section(header: Text("Institute Information")) {
                Text("Name: \(institute.name)")
                Text("University Name: \(institute.universityName)")
            }
        }
        .navigationTitle(institute.name)
    }
}

#Preview {
    InstituteDetailView(institute: Institute(id: 0, name: "Institute of Science", universityId: 0, universityName: "Maltepe University"))
}
