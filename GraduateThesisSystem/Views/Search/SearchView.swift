import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    @State private var searchText = ""
    @State private var selectedOption = "Theses"
    @State private var selectedThesisProperty = "Title"
    @State private var selectedThesisType: ThesisType? = nil
    
    let searchOptions = ["Theses", "Authors", "Supervisors", "Subject Topics", "Keywords", "Institutes"]
    let thesesProperties = ["Title", "Abstract", "Thesis No"]
    let thesisTypes : [ThesisType] = ThesisType.allCases
    
    @State private var isFilterSheetPresented = false
    
    var body: some View {
        NavigationStack {
            List {
                if selectedOption == "Theses" {
                    ForEach(viewModel.theses, id: \.self) { thesis in
                        NavigationLink(destination: ThesisDetailView(thesis: thesis)) {
                            ThesisCard(title: thesis.title, author: String(thesis.authorName), thesisNo: String(thesis.thesisNo), thesisType: thesis.thesisType)
                        }
                    }
                }
                
                if selectedOption == "Authors" {
                    ForEach(viewModel.authors, id: \.self) { author in
                        NavigationLink {
                            Text(author.name)
                        } label: {
                            Text(author.name)
                        }
                    }
                }
                
                if selectedOption == "Supervisors" {
                    ForEach(viewModel.supervisors, id: \.self) { supervisor in
                        NavigationLink {
                            Text(supervisor.name)
                        } label: {
                            Text(supervisor.name)
                        }
                    }
                }
                
                
                if selectedOption == "Subject Topics" {
                    ForEach(viewModel.subjectTopics, id: \.self) { subjectTopic in
                        NavigationLink {
                            Text(subjectTopic.name)
                        } label: {
                            Text(subjectTopic.name)
                        }
                    }
                }
                
                
                if selectedOption == "Keywords" {
                    ForEach(viewModel.keywords, id: \.self) { keyword in
                        NavigationLink {
                            Text(keyword.name)
                        } label: {
                            Text(keyword.name)
                        }
                    }
                }
                
                
                if selectedOption == "Institutes" {
                    ForEach(viewModel.institutes, id: \.self) { institute in
                        NavigationLink {
                            Text(institute.name)
                        } label: {
                            Text(institute.name)
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarItems(leading:
                Group {
                    if !viewModel.theses.isEmpty || !viewModel.authors.isEmpty || !viewModel.supervisors.isEmpty || !viewModel.subjectTopics.isEmpty || !viewModel.keywords.isEmpty || !viewModel.institutes.isEmpty {
                        Button(action: {
                            reset()
                        }) {
                            Text("Clear Results")
                        }
                    }
                },
                trailing:
                Button(action: {
                    self.isFilterSheetPresented = true
                }) {
                    Image(systemName: (selectedOption != "Theses" || selectedThesisType != nil) ? "line.horizontal.3.decrease.circle.fill" : "line.horizontal.3.decrease.circle")
                        .imageScale(.large)
                }
            )
            .overlay(
                Group {
                    if searchText.isEmpty && (!viewModel.theses.isEmpty && !searchText.isEmpty) {
                        Text("Results appear here")
                            .foregroundColor(.secondary)
                    }
                    else if viewModel.theses.isEmpty && searchText.isEmpty {
                        Text("No results found")
                            .foregroundColor(.secondary)
                    } else if viewModel.theses.isEmpty && !searchText.isEmpty {
                        Text("No results for '\(searchText)' in \(selectedOption)")
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .animation(.default, value: viewModel.theses)
            )
        }
        .searchable(text: $searchText, prompt: "Search in \(selectedOption)")
        .autocapitalization(.none)
        .disableAutocorrection(true)
        .onChange(of: searchText) { oldText, newText in
            switch selectedOption {
            case "Theses":
                switch selectedThesisProperty {
                case "Title":
                    viewModel.searchThesisTitle(query: newText, thesisType: selectedThesisType)
                case "Abstract":
                    viewModel.searchThesisAbstract(query: newText, thesisType: selectedThesisType)
                case "Thesis No":
                    viewModel.searchThesisNo(query: newText, thesisType: selectedThesisType)
                default:
                    print("Hata")
                }
            case "Author":
                viewModel.searchAuthor(query: newText)
            case "Supervisor":
                viewModel.searchSupervisor(query: newText)
            case "Subject":
                viewModel.searchSubjectTopic(query: newText)
            case "Keyword":
                viewModel.searchKeyword(query: newText)
            case "Institute":
                viewModel.searchInstitute(query: newText)
            default:
                viewModel.searchThesisTitle(query: newText, thesisType: nil)
                viewModel.searchAuthor(query: newText)
                viewModel.searchSupervisor(query: newText)
                viewModel.searchSubjectTopic(query: newText)
                viewModel.searchKeyword(query: newText)
                viewModel.searchInstitute(query: newText)
            }
        }
        .sheet(isPresented: $isFilterSheetPresented) {
            SearchFilterView(
                isPresentingFilterView: $isFilterSheetPresented,
                selectedOption: $selectedOption,
                selectedThesisProperty: $selectedThesisProperty,
                selectedThesisType: $selectedThesisType,
                searchOptions: searchOptions,
                thesesProperties: thesesProperties,
                thesisTypes: thesisTypes,
                onReset: reset
            )
        }
    }
    
    func reset() {
        viewModel.authors = []
        viewModel.theses = []
        viewModel.supervisors = []
        viewModel.subjectTopics = []
        viewModel.keywords = []
        viewModel.institutes = []
        searchText = ""
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
