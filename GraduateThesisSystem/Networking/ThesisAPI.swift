//
//  ThesisAPI.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import Foundation

struct ThesisAPI {
    static var baseUrl: URL {
        if let customBaseUrl = ProcessInfo.processInfo.environment["CUSTOM_BASE_URL"] {
            return URL(string: customBaseUrl + "/Theses")!
        } else {
            return URL(string: "")!
        }
    }
    
    static func getAllTheses(completion: @escaping (Result<[Thesis], APIError>) -> Void) {
        APIManager.shared.fetchData(url: baseUrl) { (result: Result<[Thesis], APIError>) in
            completion(result)
        }
    }
    
    static func addThesis(thesis: ThesisInput, completion: @escaping (Result<Thesis, APIError>) -> Void) {
        do {
            let jsonData = try JSONEncoder().encode(thesis)
            APIManager.shared.postData(url: baseUrl, data: jsonData) { (result: Result<Thesis, APIError>) in
                completion(result)
            }
        } catch {
            completion(.failure(.decodingError(error)))
        }
    }
    
    static func deleteThesis(with id: Int, completion: @escaping (Result<Void, APIError>) -> Void) {
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
