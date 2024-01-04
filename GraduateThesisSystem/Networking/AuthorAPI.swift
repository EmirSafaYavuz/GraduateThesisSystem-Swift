//
//  AuthorAPI.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import Foundation

struct AuthorAPI {
    static var baseUrl: URL {
        if let customBaseUrl = ProcessInfo.processInfo.environment["CUSTOM_BASE_URL"] {
            return URL(string: customBaseUrl + "/Authors")!
        } else {
            return URL(string: "")!
        }
    }

    static func getAllAuthors(completion: @escaping (Result<[Author], APIError>) -> Void) {
        APIManager.shared.fetchData(url: baseUrl) { (result: Result<[Author], APIError>) in
            completion(result)
        }
    }
    
    static func getAuthor(with id: Int, completion: @escaping (Result<Author, APIError>) -> Void) {
        let getURL = baseUrl.appendingPathComponent("\(id)")
        APIManager.shared.fetchData(url: getURL) { (result: Result<Author, APIError>) in
            completion(result)
        }
    }
    
    static func getThesesByAuthor(with id: Int, completion: @escaping (Result<[Thesis], APIError>) -> Void) {
        let getURL = baseUrl.appendingPathComponent("\(id)").appendingPathComponent("Theses")
        APIManager.shared.fetchData(url: getURL) { (result: Result<[Thesis], APIError>) in
            completion(result)
        }
    }

    static func addAuthor(author: Author, completion: @escaping (Result<Author, APIError>) -> Void) {
        do {
            let jsonData = try JSONEncoder().encode(author)
            APIManager.shared.postData(url: baseUrl, data: jsonData) { (result: Result<Author, APIError>) in
                completion(result)
            }
        } catch {
            completion(.failure(.decodingError(error)))
        }
    }
    
    static func deleteAuthor(with id: Int, completion: @escaping (Result<Void, APIError>) -> Void) {
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
