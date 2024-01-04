//
//  SupervisorAPI.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 23.12.2023.
//

import Foundation

struct SupervisorAPI {
    static var baseUrl: URL {
        if let customBaseUrl = ProcessInfo.processInfo.environment["CUSTOM_BASE_URL"] {
            return URL(string: customBaseUrl + "/Supervisors")!
        } else {
            return URL(string: "")!
        }
    }
    
    static func getAllSupervisors(completion: @escaping (Result<[Supervisor], APIError>) -> Void) {
        APIManager.shared.fetchData(url: baseUrl) { (result: Result<[Supervisor], APIError>) in
            completion(result)
        }
    }
    
    static func GetSupervisor(with id: Int, completion: @escaping (Result<Supervisor, APIError>) -> Void) {
        let url = baseUrl.appendingPathComponent("\(id)")
        
        APIManager.shared.fetchData(url: url) { (result: Result<Supervisor, APIError>) in
            completion(result)
        }
    }
    
    static func getThesesBySupervisor(with id: Int, completion: @escaping (Result<[Thesis], APIError>) -> Void) {
        let url = baseUrl.appendingPathComponent("\(id)/theses")
        
        APIManager.shared.fetchData(url: url) { (result: Result<[Thesis], APIError>) in
            completion(result)
        }
    }
    
    static func addSupervisor(supervisor: Supervisor, completion: @escaping (Result<Supervisor, APIError>) -> Void) {
        do {
            let jsonData = try JSONEncoder().encode(supervisor)
            APIManager.shared.postData(url: baseUrl, data: jsonData) { (result: Result<Supervisor, APIError>) in
                completion(result)
            }
        } catch {
            completion(.failure(.decodingError(error)))
        }
    }
    
    static func deleteSupervisor(with id: Int, completion: @escaping (Result<Void, APIError>) -> Void) {
        let deleteUrl = baseUrl.appendingPathComponent("\(id)")
        
        APIManager.shared.deleteData(url: deleteUrl) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
