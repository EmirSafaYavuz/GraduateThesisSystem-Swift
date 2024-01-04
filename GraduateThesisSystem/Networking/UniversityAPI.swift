//
//  UniversityAPI.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import Foundation

struct UniversityAPI {
    static var baseUrl: URL {
        if let customBaseUrl = ProcessInfo.processInfo.environment["CUSTOM_BASE_URL"] {
            return URL(string: customBaseUrl + "/Universities")!
        } else {
            return URL(string: "")!
        }
    }
    
    static func getAllUniversities(completion: @escaping (Result<[University], APIError>) -> Void) {
        APIManager.shared.fetchData(url: baseUrl) { (result: Result<[University], APIError>) in
            completion(result)
        }
    }
    
    static func getUniversity(by id: Int, completion: @escaping (Result<University, APIError>) -> Void) {
        let getURL = baseUrl.appendingPathComponent("\(id)")
        
        APIManager.shared.fetchData(url: getURL) { (result: Result<University, APIError>) in
            completion(result)
        }
    }
    
    static func getInstitutes(by universityId: Int, completion: @escaping (Result<[Institute], APIError>) -> Void) {
        let getURL = baseUrl.appendingPathComponent("\(universityId)/Institutes")
        
        APIManager.shared.fetchData(url: getURL) { (result: Result<[Institute], APIError>) in
            completion(result)
        }
    }
    
    static func addUniversity(university: UniversityInput, completion: @escaping (Result<University, APIError>) -> Void) {
        do {
            let jsonData = try JSONEncoder().encode(university)
            APIManager.shared.postData(url: baseUrl, data: jsonData) { (result: Result<University, APIError>) in
                completion(result)
            }
        } catch {
            completion(.failure(.decodingError(error)))
        }
    }
    
    static func deleteUniversity(with id: Int, completion: @escaping (Result<Void, APIError>) -> Void) {
        let deleteURL = baseUrl.appendingPathComponent("\(id)")

        APIManager.shared.deleteData(url: deleteURL) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
