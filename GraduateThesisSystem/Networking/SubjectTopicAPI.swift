//
//  SubjectTopicAPI.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 23.12.2023.
//

import Foundation

struct SubjectTopicAPI {
    static var baseUrl: URL {
        if let customBaseUrl = ProcessInfo.processInfo.environment["CUSTOM_BASE_URL"] {
            return URL(string: customBaseUrl + "/SubjectTopics")!
        } else {
            return URL(string: "")!
        }
    }
    
    static func getAllSubjectTopics(completion: @escaping (Result<[SubjectTopic], APIError>) -> Void) {
        APIManager.shared.fetchData(url: baseUrl) { (result: Result<[SubjectTopic], APIError>) in
            completion(result)
        }
    }
    
    static func addSubjectTopic(subjectTopic: SubjectTopic, completion: @escaping (Result<SubjectTopic, APIError>) -> Void) {
        do {
            let jsonData = try JSONEncoder().encode(subjectTopic)
            APIManager.shared.postData(url: baseUrl, data: jsonData) { (result: Result<SubjectTopic, APIError>) in
                completion(result)
            }
        } catch {
            completion(.failure(.decodingError(error)))
        }
    }
    
    static func deleteSubjectTopic(with id: Int, completion: @escaping (Result<Void, APIError>) -> Void) {
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
