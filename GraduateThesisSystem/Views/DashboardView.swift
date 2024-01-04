//
//  DashboardView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: ThesesView()) {
                    DashboardCardView(title: "Theses", value: String(viewModel.counts.thesesCount))
                }
                NavigationLink(destination: AuthorsView()) {
                    DashboardCardView(title: "Authors", value: String(viewModel.counts.authorsCount))
                }
                NavigationLink(destination: SupervisorsView()) {
                    DashboardCardView(title: "Supervisors", value: String(viewModel.counts.supervisorsCount))
                }
                NavigationLink(destination: UniversitiesView()) {
                    DashboardCardView(title: "Universities", value: String(viewModel.counts.universitiesCount))
                }
                NavigationLink(destination: InstitutesView()) {
                    DashboardCardView(title: "Institutes", value: String(viewModel.counts.institutesCount))
                }
                NavigationLink(destination: LanguagesView()) {
                    DashboardCardView(title: "Languages", value: String(viewModel.counts.languagesCount))
                }
                NavigationLink(destination: LocationsView()) {
                    DashboardCardView(title: "Locations", value: String(viewModel.counts.locationsCount))
                }
                NavigationLink(destination: SubjectTopicsView()) {
                    DashboardCardView(title: "Subject Topics", value: String(viewModel.counts.subjectTopicsCount))
                }
                NavigationLink(destination: KeywordsView()) {
                    DashboardCardView(title: "Keywords", value: String(viewModel.counts.keywordsCount))
                }
            }
            .onAppear {
                viewModel.getCounts()
            }
            .navigationTitle("Home Page")
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    DashboardView()
}
