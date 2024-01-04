import SwiftUI

struct ThesisDetailView: View {
    @State var isEditThesisViewPresented = false
    @State private var editedThesis: Thesis
    let thesis: Thesis

    init(thesis: Thesis) {
        self.thesis = thesis
        // Initialize the state variable with the original thesis data
        _editedThesis = State(initialValue: thesis)
    }

    var body: some View {
        Form {
            Section(header: Text("Thesis Details")) {
                Text("Title: \(thesis.title)")
                Text("Abstract: \(thesis.abstract)")
                Text("Year: \(String(thesis.year))")
                Text("Number of Pages: \(thesis.numOfPages)")
                Text("Submission Date: \(formatSubmissionDate(thesis.submissionDate))")
            }

            Section(header: Text("Author Information")) {
                Text("Author ID: \(thesis.authorId)")
                Text("Author Name: \(thesis.authorName)")
            }

            Section(header: Text("Language Information")) {
                Text("Language ID: \(thesis.languageId)")
                Text("Language Name: \(thesis.languageName)")
            }
            
            Section(header: Text("Supervisor Information")) {
                Text("Supervisor ID: \(thesis.supervisorId)")
                Text("Supervisor Name: \(thesis.supervisorName)")
            }

            if let coSupervisorId = thesis.coSupervisorId, let coSupervisorName = thesis.coSupervisorName {
                Section(header: Text("Co-Supervisor Information")) {
                    Text("Co-Supervisor ID: \(coSupervisorId)")
                    Text("Co-Supervisor Name: \(coSupervisorName)")
                }
            }
            
            Section(header: Text("Institute Information")) {
                Text("Institute ID: \(thesis.instituteId)")
                Text("Institute Name: \(thesis.instituteName)")
            }

            Section(header: Text("Thesis Type")) {
                Text("Type: \(thesis.thesisType)")
            }
        }
        .navigationTitle("Thesis Detail")
        .navigationBarItems(trailing:
            Button(action: {
            isEditThesisViewPresented = true
            }) {
                Text("Edit")
            }
        )
        .sheet(isPresented: $isEditThesisViewPresented) {
            // Your Edit View goes here
            // You can create a new SwiftUI view for editing and present it as a sheet
            // For example:
            EditThesisView(thesis: $editedThesis, isPresented: $isEditThesisViewPresented)
        }
    }
    
    func formatSubmissionDate(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        
        if let formattedDate = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "dd MMMM yyyy"
            return dateFormatter.string(from: formattedDate)
        } else {
            return "Invalid Date"
        }
    }
}

struct ThesisDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleThesis = Thesis(id: 1, thesisNo: 101, title: "Sample Thesis", abstract: "This is a sample thesis abstract.", year: 2023, numOfPages: 20, submissionDate: "2023-12-03T10:45:47.723894", authorId: 2, authorName: "John Doe", languageId: 1, languageName: "English", coSupervisorId: 3, coSupervisorName: "Dr. Jane Smith", instituteId: 4, instituteName: "XYZ Institute", supervisorId: 5, supervisorName: "Prof. Alan Johnson", thesisType: "Master's Thesis")

        ThesisDetailView(thesis: sampleThesis)
    }
}
