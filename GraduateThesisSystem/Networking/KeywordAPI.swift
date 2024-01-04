//
//  KeywordAPI.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 27.12.2023.
//

import Foundation

struct KeywordAPI {
    static var baseUrl: URL {
        if let customBaseUrl = ProcessInfo.processInfo.environment["CUSTOM_BASE_URL"] {
            return URL(string: customBaseUrl + "/Keywords")!
        } else {
            return URL(string: "")!
        }
    }
    
    static func getAllKeywords(completion: @escaping (Result<[Keyword], APIError>) -> Void) {
        APIManager.shared.fetchData(url: baseUrl) { (result: Result<[Keyword], APIError>) in
            completion(result)
        }
    }
    
    static func getKeyword(with id: Int, completion: @escaping (Result<Keyword, APIError>) -> Void) {
        let url = baseUrl.appendingPathComponent("\(id)")
        
        APIManager.shared.fetchData(url: url) { (result: Result<Keyword, APIError>) in
            completion(result)
        }
    }
    
    static func getThesesByKeyword(with id: Int, completion: @escaping (Result<[Thesis], APIError>) -> Void) {
        let url = baseUrl.appendingPathComponent("\(id)/theses")
        
        APIManager.shared.fetchData(url: url) { (result: Result<[Thesis], APIError>) in
            completion(result)
        }
    }
    
    static func addKeyword(keyword: Keyword, completion: @escaping (Result<Keyword, APIError>) -> Void) {
        do {
            let jsonData = try JSONEncoder().encode(keyword)
            APIManager.shared.postData(url: baseUrl, data: jsonData) { (result: Result<Keyword, APIError>) in
                completion(result)
            }
        } catch {
            completion(.failure(.decodingError(error)))
        }
    }
    
    static func deleteKeyword(with id: Int, completion: @escaping (Result<Void, APIError>) -> Void) {
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
