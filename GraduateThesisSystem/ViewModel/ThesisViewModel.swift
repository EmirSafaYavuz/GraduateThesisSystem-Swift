//
//  ThesisViewModel.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import Foundation

class ThesisViewModel: ObservableObject {
    @Published var theses: [Thesis] = []
    @Published var authors: [Author] = []
    @Published var universities: [University] = []
    @Published var institutesOfUniversity: [Institute] = []
    @Published var languages: [Language] = []
    @Published var supervisors: [Supervisor] = []
    @Published var subjectTopics: [SubjectTopic] = []
    
    func getAllTheses() {
        ThesisAPI.getAllTheses { result in
            switch result {
            case .success(let fetchedTheses):
                DispatchQueue.main.async {
                    self.theses = fetchedTheses
                }
            case .failure(let error):
                print("Error loading theses: \(error)")
            }
        }
    }
    
    func addThesis(thesis: ThesisInput) {
        ThesisAPI.addThesis(thesis: thesis) { result in
            switch result {
            case .success(let addedThesis):
                DispatchQueue.main.async {
                    self.theses.append(addedThesis)
                }
            case .failure(let error):
                print("Error adding thesis: \(error)")
            }
        }
    }
    
    func deleteThesis(with thesisId: Int?) {
        guard let thesisId = thesisId else {
            print("Thesis id is nil, cannot delete.")
            return
        }
        
        ThesisAPI.deleteThesis(with: thesisId) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.theses.removeAll { $0.id == thesisId }
                }
            case .failure(let error):
                print("Error deleting thesis: \(error)")
            }
        }
    }
    
    func getAuthors() {
        AuthorAPI.getAllAuthors { result in
            switch result {
            case .success(let fetchedAuthors):
                DispatchQueue.main.async {
                    self.authors = fetchedAuthors
                }
            case .failure(let error):
                print("Error loading authors: \(error)")
            }
        }
    }
    
    func getUniversities() {
        UniversityAPI.getAllUniversities { result in
            switch result {
            case .success(let fetchedUniversities):
                DispatchQueue.main.async {
                    self.universities = fetchedUniversities
                }
            case .failure(let error):
                print("Error loading universities: \(error)")
            }
        }
    }
    
    func getInstitutes(by universityId: Int) {
        UniversityAPI.getInstitutes(by: universityId) { result in
            switch result {
            case .success(let fetchedInstitutes):
                DispatchQueue.main.async {
                    self.institutesOfUniversity = fetchedInstitutes
                }
            case .failure(let error):
                print("Error loading institutes: \(error)")
            }
        }
    }
    
    func getLanguages() {
        LanguageAPI.getAllLanguages { result in
            switch result {
            case .success(let fetchedLanguages):
                DispatchQueue.main.async {
                    self.languages = fetchedLanguages
                }
            case .failure(let error):
                print("Error loading languages: \(error)")
            }
        }
    }
    
    func getSupervisors() {
        SupervisorAPI.getAllSupervisors { result in
            switch result {
            case .success(let fetchedSupervisors):
                DispatchQueue.main.async {
                    self.supervisors = fetchedSupervisors
                }
            case .failure(let error):
                print("Error loading supervisors: \(error)")
            }
        }
    }
    
    func getSubjectTopics() {
        SubjectTopicAPI.getAllSubjectTopics { result in
            switch result {
            case .success(let fetchedSubjectTopics):
                DispatchQueue.main.async {
                    self.subjectTopics = fetchedSubjectTopics
                }
            case .failure(let error):
                print("Error loading subject topics: \(error)")
            }
        }
    }
}
