//
//  SupervisorViewModel.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 23.12.2023.
//

import Foundation

class SupervisorViewModel: ObservableObject {
    @Published var supervisors: [Supervisor] = []
    @Published var thesesOfSupervisor: [Thesis] = []
    
    func getAllSupervisors() {
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
    
    func getSupervisor(with supervisorId: Int) {
        SupervisorAPI.GetSupervisor(with: supervisorId) { result in
            switch result {
            case .success(let fetchedSupervisor):
                DispatchQueue.main.async {
                    self.supervisors.append(fetchedSupervisor)
                }
            case .failure(let error):
                print("Error loading supervisor: \(error)")
            }
        }
    }
    
    func getThesesBySupervisor(with supervisorId: Int) {
        SupervisorAPI.getThesesBySupervisor(with: supervisorId) { result in
            switch result {
            case .success(let fetchedTheses):
                DispatchQueue.main.async {
                    self.thesesOfSupervisor = fetchedTheses
                }
            case .failure(let error):
                print("Error loading supervisor's theses: \(error)")
            }
        }
    }
    
    func addSupervisor(supervisor: Supervisor) {
        SupervisorAPI.addSupervisor(supervisor: supervisor) { result in
            switch result {
            case .success(let addedSupervisor):
                DispatchQueue.main.async {
                    self.supervisors.append(addedSupervisor)
                }
            case .failure(let error):
                print("Error adding supervisor: \(error)")
            }
        }
    }
    
    func deleteSupervisor(with supervisorId: Int?) {
        guard let supervisorId = supervisorId else {
            print("Supervisor id is nil, cannot delete.")
            return
        }
        
        SupervisorAPI.deleteSupervisor(with: supervisorId) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.supervisors.removeAll { $0.id == supervisorId }
                }
            case .failure(let error):
                print("Error deleting supervisor: \(error)")
            }
        }
    }
}
