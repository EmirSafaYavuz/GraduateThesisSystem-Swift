//
//  LocationAPI.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 23.12.2023.
//

import Foundation

struct LocationAPI {
    static var baseUrl: URL {
        if let customBaseUrl = ProcessInfo.processInfo.environment["CUSTOM_BASE_URL"] {
            return URL(string: customBaseUrl + "/Locations")!
        } else {
            return URL(string: "")!
        }
    }
    
    static func getAllLocations(completion: @escaping (Result<[Location], APIError>) -> Void) {
        APIManager.shared.fetchData(url: baseUrl) { (result: Result<[Location], APIError>) in
            completion(result)
        }
    }
    
    static func addLocation(location: Location, completion: @escaping (Result<Location, APIError>) -> Void) {
        do {
            let jsonData = try JSONEncoder().encode(location)
            APIManager.shared.postData(url: baseUrl, data: jsonData) { (result: Result<Location, APIError>) in
                completion(result)
            }
        } catch {
            completion(.failure(.decodingError(error)))
        }
    }
    
    static func deleteLocation(with id: Int, completion: @escaping (Result<Void, APIError>) -> Void) {
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
