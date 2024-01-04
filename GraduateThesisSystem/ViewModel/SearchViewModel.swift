//
//  SearchViewModel.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 29.12.2023.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var theses: [Thesis] = []
    @Published var authors: [Author] = []
    @Published var institutes: [Institute] = []
    @Published var supervisors: [Supervisor] = []
    @Published var subjectTopics: [SubjectTopic] = []
    @Published var keywords: [Keyword] = []
    
    func searchThesisTitle(query: String, thesisType: ThesisType?) {
        SearchAPI.searchThesisTitle(query: query, thesisType: thesisType) { result in
            switch result {
            case .success(let fetchedTheses):
                DispatchQueue.main.async {
                    self.theses = fetchedTheses
                }
            case .failure(let error):
                print("Error searching thesis title: \(error)")
            }
        }
    }
    
    func searchThesisAbstract(query: String, thesisType: ThesisType?) {
        SearchAPI.searchThesisAbstract(query: query, thesisType: thesisType) { result in
            switch result {
            case .success(let fetchedTheses):
                DispatchQueue.main.async {
                    self.theses = fetchedTheses
                }
            case .failure(let error):
                print("Error searching thesis abstract: \(error)")
            }
        }
    }
    
    func searchThesisNo(query: String, thesisType: ThesisType?) {
        SearchAPI.searchThesisNo(query: query, thesisType: thesisType) { result in
            switch result {
            case .success(let fetchedTheses):
                DispatchQueue.main.async {
                    self.theses = fetchedTheses
                }
            case .failure(let error):
                print("Error searching thesis no: \(error)")
            }
        }
    }
    
    func searchAuthor(query: String) {
        SearchAPI.searchAuthor(query: query) { result in
            switch result {
            case .success(let fetchedAuthors):
                DispatchQueue.main.async {
                    self.authors = fetchedAuthors
                }
            case .failure(let error):
                print("Error searching author name: \(error)")
            }
        }
    }
    
    func searchInstitute(query: String) {
        SearchAPI.searchInstitute(query: query) { result in
            switch result {
            case .success(let fetchedInstitutions):
                DispatchQueue.main.async {
                    self.institutes = fetchedInstitutions
                }
            case .failure(let error):
                print("Error searching institution name: \(error)")
            }
        }
    }
    
    func searchSupervisor(query: String) {
        SearchAPI.searchSupervisor(query: query) { result in
            switch result {
            case .success(let fetchedSupervisors):
                DispatchQueue.main.async {
                    self.supervisors = fetchedSupervisors
                }
            case .failure(let error):
                print("Error searching supervisor name: \(error)")
            }
        }
    }
    
    func searchSubjectTopic(query: String) {
        SearchAPI.searchSubjectTopic(query: query) { result in
            switch result {
            case .success(let fetchedSubjectTopics):
                DispatchQueue.main.async {
                    self.subjectTopics = fetchedSubjectTopics
                }
            case .failure(let error):
                print("Error searching subject topic name: \(error)")
            }
        }
    }
    
    func searchKeyword(query: String) {
        SearchAPI.searchKeyword(query: query) { result in
            switch result {
            case .success(let fetchedKeywords):
                DispatchQueue.main.async {
                    self.keywords = fetchedKeywords
                }
            case .failure(let error):
                print("Error searching keyword: \(error)")
            }
        }
    }
    
}
