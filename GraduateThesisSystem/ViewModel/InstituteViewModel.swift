//
//  InstituteViewModel.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 22.12.2023.
//

import Foundation

class InstituteViewModel: ObservableObject {
    @Published var institutes: [Institute] = []
    
    func getAllInstitutes() {
        InstituteAPI.getAllInstitutes { result in
            switch result {
            case .success(let fetchedInstitutes):
                DispatchQueue.main.async {
                    self.institutes = fetchedInstitutes
                }
            case .failure(let error):
                print("Error loading institutes: \(error)")
            }
        }
    }
    
    func addInstitute(institute: Institute) {
        InstituteAPI.addInstitute(institute: institute) { result in
            switch result {
            case .success(let addedInstitute):
                DispatchQueue.main.async {
                    self.institutes.append(addedInstitute)
                }
            case .failure(let error):
                print("Error adding institute: \(error)")
            }
        }
    }
    
    func deleteInstitute(with instituteId: Int?) {
        guard let instituteId = instituteId else {
            print("Institute id is nil, cannot delete.")
            return
        }
        
        InstituteAPI.deleteInstitute(with: instituteId) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.institutes.removeAll { $0.id == instituteId }
                }
            case .failure(let error):
                print("Error deleting institute: \(error)")
            }
        }
    }
}
