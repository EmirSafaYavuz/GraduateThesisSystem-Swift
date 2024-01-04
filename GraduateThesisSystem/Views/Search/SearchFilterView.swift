//
//  SearchFilterView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 24.12.2023.
//

import SwiftUI

struct SearchFilterView: View {
    @Binding var isPresentingFilterView: Bool
    @Binding var selectedOption: String
    @Binding var selectedThesisProperty: String
    @Binding var selectedThesisType: ThesisType?
    let searchOptions: [String]
    let thesesProperties: [String]
    let thesisTypes: [ThesisType]
    
    var onReset: () -> Void
        
    var body: some View {
        NavigationStack {
            Form {
                Picker("Search In", selection: $selectedOption) {
                    ForEach(searchOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)

                if selectedOption == "Theses" {
                    Section(header: Text("Thesis Properties")) {
                        Picker("Thesis Property", selection: $selectedThesisProperty) {
                            ForEach(thesesProperties, id: \.self) {
                                Text($0)
                            }
                        }
                        
                        Picker("Thesis Type", selection: $selectedThesisType) {
                            ForEach(thesisTypes, id: \.self) { thesisType in
                                Text(thesisType.rawValue.capitalized).tag(thesisType as ThesisType?)
                            }
                            Text("Any").tag(nil as ThesisType?)
                        }
                    }
                }
            
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Reset") {
                        selectedOption = "Theses"
                        selectedThesisProperty = "Title"
                        selectedThesisType = nil
                        
                        isPresentingFilterView = false
                        onReset()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingFilterView = false
                    }) {
                        Text("Apply")
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

#Preview {
    SearchFilterView(isPresentingFilterView: .constant(true), selectedOption: .constant("Theses"), selectedThesisProperty: .constant("Both"), selectedThesisType: .constant(.master), searchOptions: ["Theses", "Author", "Supervisor", "Subject Topic", "Keyword", "Institute"], thesesProperties: ["Title", "Abstract"], thesisTypes: [.master, .doctorate, .specializationInMedicine, .proficiencyInArt], onReset: {})
}
