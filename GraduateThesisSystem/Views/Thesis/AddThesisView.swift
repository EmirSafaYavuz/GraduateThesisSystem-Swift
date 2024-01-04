//
//  AddThesisView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import SwiftUI

struct AddThesisView: View {
    @ObservedObject var viewModel: ThesisViewModel
    @Binding var isPresented: Bool
    
    let authors = ["Emir Safa Yavuz", "Yağmur Demiröz", "İsa Kaan Albayrak"]
    let thesisTypes:[ThesisType] = ThesisType.allCases
    
    @State private var supervisorPickers: [Int] = []

    @State private var thesisNo = ""
    @State private var thesisTitle = ""
    @State private var abstract = ""
    @State private var numOfPages = ""
    
    @State private var selectedYear = Calendar.current.component(.year, from: Date())
        let years: [Int] = {
            let currentYear = Calendar.current.component(.year, from: Date())
            return Array((currentYear - 30)...currentYear)
        }()
    
    @State private var selectedThesisType:ThesisType = ThesisType.master
    @State private var selectedUniversity = 0
    @State private var selectedInstitute = 0
    @State private var selectedLanguage = 0
    @State private var selectedAuthor = 0
    @State private var selectedSupervisor = 0
    @State private var selectedCoSupervisor = 0
    @State private var selectedSubjectTopics: [SubjectTopic] = []
    @State private var keywords: [String] = []
    @State private var newKeyword = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Thesis")) {
                    TextField("Thesis No", text: $thesisNo)
                        .keyboardType(.numberPad)
                    
                    TextField("Title", text: $thesisTitle)
                        .lineLimit(nil)
                    
                    TextField("Abstract", text: $abstract)
                        .lineLimit(nil)
                    
                    TextField("Num of Pages", text: $numOfPages)
                        .keyboardType(.numberPad)
                    
                    Picker("Thesis Type", selection: $selectedThesisType) {
                        ForEach(thesisTypes, id: \.self) { thesisType in
                            Text(thesisType.rawValue.capitalized).tag(thesisType as ThesisType)
                        }
                    }
                    
                    Picker("Language", selection: $selectedLanguage) {
                        Text("Select").tag(0)
                        ForEach(viewModel.languages, id: \.self) { language in
                            Text(language.name).tag(language.id)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Published Year")
                        Picker("Published Year", selection: $selectedYear) {
                            ForEach(years, id: \.self) { year in
                                Text(String(format: "%d", year))
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                }
                
                Section(header: Text("Author")) {
                    Picker("Author", selection: $selectedAuthor) {
                        Text("Select").tag(0)
                        ForEach(viewModel.authors, id: \.self) { author in
                            Text(author.name).tag(author.id)
                        }
                    }
                }
                
                Section(header: Text("University")) {
                    Picker("University", selection: $selectedUniversity) {
                        Text("Select").tag(0)
                        ForEach(viewModel.universities, id: \.self) { university in
                            Text(university.name).tag(university.id)
                        }
                    }
                    
                    if viewModel.institutesOfUniversity.isEmpty {
                        Picker("Institute", selection: $selectedInstitute) {
                            Text("Select University First").tag(0)
                        }
                        .disabled(true)
                        .pickerStyle(.navigationLink)
                    } else {
                        Picker("Institute", selection: $selectedInstitute) {
                            Text("Select Institute").tag(0)
                            ForEach(viewModel.institutesOfUniversity, id: \.self) { institute in
                                Text(institute.name).tag(institute.id)
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                }
                
                Section(header: Text("Supervisor")) {
                    Picker("Supervisor", selection: $selectedSupervisor) {
                        Text("Select").tag(0)
                        ForEach(viewModel.supervisors, id: \.self) { supervisor in
                            Text(supervisor.name).tag(supervisor.id)
                        }
                    }
                    
                    List {
                        ForEach(supervisorPickers.indices, id: \.self) { index in
                            Picker("Supervisor \(index + 2)", selection: supervisorPickersBinding[index]) {
                                Text("Select").tag(0)
                                ForEach(viewModel.supervisors, id: \.self) { supervisor in
                                    Text(supervisor.name).tag(supervisor.id)
                                }
                            }
                            .id(index)
                        }
                        .onDelete { indices in
                            supervisorPickers.remove(atOffsets: indices)
                        }
                    }
                    
                    Button(action: {
                        if supervisorPickersBinding.last?.wrappedValue != 0 && selectedSupervisor != 0 {
                            supervisorPickers.append(0)
                        }
                    }) {
                        Label("Add Supervisor", systemImage: "plus.circle")
                    }
                    .disabled(supervisorPickersBinding.last?.wrappedValue == 0 || selectedSupervisor == 0)
                }
                
                Section(header: Text("Co Supervisor")) {
                    Picker("Co-Supervisor", selection: $selectedCoSupervisor) {
                        Text("Optional").tag(0)
                        ForEach(viewModel.supervisors, id: \.self) { supervisor in
                            if isSupervisorAvailable(supervisor.id) {
                                Text(supervisor.name).tag(supervisor.id)
                            }
                        }
                    }
                }
                
                Section(header: Text("Subject Topic")) {
                    MultipleSelectionList(items: $viewModel.subjectTopics, selections: $selectedSubjectTopics)
                }
                
                Section(header: Text("Keyword")) {
                    List {
                        HStack {
                            TextField("New Keyword", text: $newKeyword)

                            Button(action: {
                                if !newKeyword.isEmpty {
                                    keywords.append(newKeyword)
                                    newKeyword = ""
                                }
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.blue)
                            }
                        }

                        ForEach(keywords.indices, id: \.self) { index in
                            HStack {
                                TextField("Keyword", text: $keywords[index], onCommit: {
                                    // You can add any additional functionality here if needed
                                })

                                Button(action: {
                                    keywords.remove(at: index)
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                }



            }
            .onAppear {
                viewModel.getAuthors()
                viewModel.getLanguages()
                viewModel.getUniversities()
                viewModel.getSupervisors()
                viewModel.getSubjectTopics()
            }
            .onChange(of: selectedUniversity, { oldValue, newValue in
                viewModel.getInstitutes(by: newValue)
            })
            .navigationTitle("Add Thesis")
            .toolbar {
               ToolbarItem(placement: .cancellationAction) {
                   Button("Dismiss") {
                       isPresented = false
                   }
               }
               ToolbarItem(placement: .confirmationAction) {
                   Button("Add") {
                       let selectedSupervisors = supervisorPickers.enumerated().map { $0.element }

                       let newThesis = ThesisInput(
                           thesisNo: Int(thesisNo) ?? 000000,
                           title: thesisTitle,
                           abstract: abstract,
                           year: selectedYear,
                           numOfPages: Int(numOfPages) ?? 0,
                           authorId: selectedAuthor,
                           languageId: selectedLanguage,
                           coSupervisorId: selectedCoSupervisor,
                           instituteId: selectedInstitute,
                           supervisorId: selectedSupervisor,
                           thesisType: selectedThesisType.index,
                           supervisorIdList: selectedSupervisors
                       )

                       
                       viewModel.addThesis(thesis: newThesis)
                       isPresented = false
                   }
               }
           }
        }
    }
    
    private var supervisorPickersBinding: [Binding<Int>] {
        (0..<supervisorPickers.count).map { index in
            Binding(
                get: { supervisorPickers[index] },
                set: { newValue in
                    supervisorPickers[index] = newValue
                }
            )
        }
    }
    
    var selectedSupervisorsText: String {
        var text = "Selected Supervisors: "
        for (_, supervisorId) in supervisorPickers.enumerated() {
            if supervisorId != 0 {
                text += "\(supervisorId), "
            }
        }
        text = String(text.dropLast(2))
        return text
    }

    func isSupervisorAvailable(_ supervisorId: Int) -> Bool {
        if selectedSupervisor == supervisorId {
            return false
        }
        
        if(supervisorPickers.contains(supervisorId)) {
            return false
        }
        

        return true
    }
}

struct MultipleSelectionList: View {
    @Binding var items: [SubjectTopic]
    @Binding var selections: [SubjectTopic]

    var body: some View {
        List {
            ForEach(self.items, id: \.self) { item in
                MultipleSelectionRow(title: item.name, isSelected: self.selections.contains(item)) {
                    if self.selections.contains(item) {
                        self.selections.removeAll(where: { $0 == item })
                    }
                    else {
                        self.selections.append(item)
                    }
                }
            }
        }
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                    .foregroundColor(.primary)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview {
    AddThesisView(viewModel: ThesisViewModel(), isPresented: .constant(true))
}
