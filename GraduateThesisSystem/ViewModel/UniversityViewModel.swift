//
//  UniversityViewModel.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import Foundation

class UniversityViewModel: ObservableObject {
    @Published var universities: [University] = []
    @Published var institutesOfUniversity: [Institute] = []
    @Published var locations: [Location] = []
    
    func getAllUniversities() {
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
    
    func getUniversity(by universityId: Int?) {
        guard let universityId = universityId else {
            print("University id is nil, cannot fetch.")
            return
        }
        
        UniversityAPI.getUniversity(by: universityId) { result in
            switch result {
            case .success(let fetchedUniversity):
                DispatchQueue.main.async {
                    self.universities.append(fetchedUniversity)
                }
            case .failure(let error):
                print("Error fetching university: \(error)")
            }
        }
    }
    
    func getInstitutes(by universityId: Int?) {
        guard let universityId = universityId else {
            print("University id is nil, cannot fetch.")
            return
        }
        
        UniversityAPI.getInstitutes(by: universityId) { result in
            switch result {
            case .success(let fetchedInstitutes):
                DispatchQueue.main.async {
                    self.institutesOfUniversity = fetchedInstitutes
                }
            case .failure(let error):
                print("Error fetching institutes: \(error)")
            }
        }
    }
    
    func addUniversity(university: UniversityInput) {
        UniversityAPI.addUniversity(university: university) { result in
            switch result {
            case .success(let addedUniversity):
                DispatchQueue.main.async {
                    self.universities.append(addedUniversity)
                }
            case .failure(let error):
                print("Error adding university: \(error)")
            }
        }
    }
    
    func deleteUniversity(with universityId: Int?) {
        guard let universityId = universityId else {
            print("University id is nil, cannot delete.")
            return
        }
        
        UniversityAPI.deleteUniversity(with: universityId) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.universities.removeAll { $0.id == universityId }
                }
            case .failure(let error):
                print("Error deleting university: \(error)")
            }
        }
    }
    
    func getAllLocations() {
        LocationAPI.getAllLocations { result in
            switch result {
            case .success(let fetchedLocations):
                DispatchQueue.main.async {
                    self.locations = fetchedLocations
                }
            case .failure(let error):
                print("Error loading locations: \(error)")
            }
        }
    }
}
