//
//  InstituteAPI.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 22.12.2023.
//

import Foundation

struct InstituteAPI {
    static var baseUrl: URL {
        if let customBaseUrl = ProcessInfo.processInfo.environment["CUSTOM_BASE_URL"] {
            return URL(string: customBaseUrl + "/Institutes")!
        } else {
            return URL(string: "")!
        }
    }
    
    static func getAllInstitutes(completion: @escaping (Result<[Institute], APIError>) -> Void) {
        APIManager.shared.fetchData(url: baseUrl) { (result: Result<[Institute], APIError>) in
            completion(result)
        }
    }
    
    static func addInstitute(institute: Institute, completion: @escaping (Result<Institute, APIError>) -> Void) {
        do {
            let jsonData = try JSONEncoder().encode(institute)
            APIManager.shared.postData(url: baseUrl, data: jsonData) { (result: Result<Institute, APIError>) in
                completion(result)
            }
        } catch {
            completion(.failure(.decodingError(error)))
        }
    }
    
    static func deleteInstitute(with id: Int, completion: @escaping (Result<Void, APIError>) -> Void) {
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
