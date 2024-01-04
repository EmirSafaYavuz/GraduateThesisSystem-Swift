//
//  LanguageAPI.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 22.12.2023.
//

import Foundation

struct LanguageAPI {
    static var baseUrl: URL {
        if let customBaseUrl = ProcessInfo.processInfo.environment["CUSTOM_BASE_URL"] {
            return URL(string: customBaseUrl + "/Languages")!
        } else {
            return URL(string: "")!
        }
    }
    
    static func getAllLanguages(completion: @escaping (Result<[Language], APIError>) -> Void) {
        APIManager.shared.fetchData(url: baseUrl) { (result: Result<[Language], APIError>) in
            completion(result)
        }
    }
    
    static func addLanguage(language: Language, completion: @escaping (Result<Language, APIError>) -> Void) {
        do {
            let jsonData = try JSONEncoder().encode(language)
            APIManager.shared.postData(url: baseUrl, data: jsonData) { (result: Result<Language, APIError>) in
                completion(result)
            }
        } catch {
            completion(.failure(.decodingError(error)))
        }
    }
    
    static func deleteLanguage(with id: Int, completion: @escaping (Result<Void, APIError>) -> Void) {
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
