//
//  SearchAPI.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 27.12.2023.
//

import Foundation

struct SearchAPI {
    static var baseUrl: URL {
        if let customBaseUrl = ProcessInfo.processInfo.environment["CUSTOM_BASE_URL"] {
            return URL(string: customBaseUrl + "/Search")!
        } else {
            return URL(string: "")!
        }
    }

    //http://localhost:5291/api/Search/ThesisTitle?query=deneme&thesisType=1
    static func searchThesisTitle(query: String, thesisType: ThesisType?, completion: @escaping (Result<[Thesis], APIError>) -> Void) {
        var components = URLComponents(url: baseUrl.appendingPathComponent("Thesis/Title"), resolvingAgainstBaseURL: true)!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "query", value: query)
        ]

        if let thesisType = thesisType {
            queryItems.append(URLQueryItem(name: "thesisType", value: String(thesisType.index)))
        }

        components.queryItems = queryItems

        guard let finalUrl = components.url else {
            completion(.failure(.invalidURL))
            return
        }

        APIManager.shared.fetchData(url: finalUrl) { (result: Result<[Thesis], APIError>) in
            completion(result)
        }
    }

    static func searchThesisAbstract(query: String, thesisType: ThesisType?, completion: @escaping (Result<[Thesis], APIError>) -> Void) {
        var components = URLComponents(url: baseUrl.appendingPathComponent("Thesis/Abstract"), resolvingAgainstBaseURL: true)!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "query", value: query)
        ]

        if let thesisType = thesisType {
            queryItems.append(URLQueryItem(name: "thesisType", value: String(thesisType.index)))
        }

        components.queryItems = queryItems

        guard let finalUrl = components.url else {
            completion(.failure(.invalidURL))
            return
        }

        APIManager.shared.fetchData(url: finalUrl) { (result: Result<[Thesis], APIError>) in
            completion(result)
        }
    }
    
    static func searchThesisNo(query: String, thesisType: ThesisType?, completion: @escaping (Result<[Thesis], APIError>) -> Void) {
        var components = URLComponents(url: baseUrl.appendingPathComponent("Thesis/No"), resolvingAgainstBaseURL: true)!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "query", value: query)
        ]

        if let thesisType = thesisType {
            queryItems.append(URLQueryItem(name: "thesisType", value: String(thesisType.index)))
        }

        components.queryItems = queryItems

        guard let finalUrl = components.url else {
            completion(.failure(.invalidURL))
            return
        }

        APIManager.shared.fetchData(url: finalUrl) { (result: Result<[Thesis], APIError>) in
            completion(result)
        }
    }
    
    static func searchAuthor(query: String, completion: @escaping (Result<[Author], APIError>) -> Void) {
        var components = URLComponents(url: baseUrl.appendingPathComponent("Author"), resolvingAgainstBaseURL: true)!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "query", value: query)
        ]

        components.queryItems = queryItems

        guard let finalUrl = components.url else {
            completion(.failure(.invalidURL))
            return
        }

        APIManager.shared.fetchData(url: finalUrl) { (result: Result<[Author], APIError>) in
            completion(result)
        }
    }
    
    static func searchInstitute(query: String, completion: @escaping (Result<[Institute], APIError>) -> Void) {
        var components = URLComponents(url: baseUrl.appendingPathComponent("Institute"), resolvingAgainstBaseURL: true)!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "query", value: query)
        ]

        components.queryItems = queryItems

        guard let finalUrl = components.url else {
            completion(.failure(.invalidURL))
            return
        }

        APIManager.shared.fetchData(url: finalUrl) { (result: Result<[Institute], APIError>) in
            completion(result)
        }
    }
    
    static func searchSupervisor(query: String, completion: @escaping (Result<[Supervisor], APIError>) -> Void) {
        var components = URLComponents(url: baseUrl.appendingPathComponent("Supervisor"), resolvingAgainstBaseURL: true)!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "query", value: query)
        ]

        components.queryItems = queryItems

        guard let finalUrl = components.url else {
            completion(.failure(.invalidURL))
            return
        }

        APIManager.shared.fetchData(url: finalUrl) { (result: Result<[Supervisor], APIError>) in
            completion(result)
        }
    }
    
    static func searchSubjectTopic(query: String, completion: @escaping (Result<[SubjectTopic], APIError>) -> Void) {
        var components = URLComponents(url: baseUrl.appendingPathComponent("SubjectTopic"), resolvingAgainstBaseURL: true)!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "query", value: query)
        ]

        components.queryItems = queryItems

        guard let finalUrl = components.url else {
            completion(.failure(.invalidURL))
            return
        }

        APIManager.shared.fetchData(url: finalUrl) { (result: Result<[SubjectTopic], APIError>) in
            completion(result)
        }
    }
    
    static func searchKeyword(query: String, completion: @escaping (Result<[Keyword], APIError>) -> Void) {
        var components = URLComponents(url: baseUrl.appendingPathComponent("Keyword"), resolvingAgainstBaseURL: true)!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "query", value: query)
        ]

        components.queryItems = queryItems

        guard let finalUrl = components.url else {
            completion(.failure(.invalidURL))
            return
        }

        APIManager.shared.fetchData(url: finalUrl) { (result: Result<[Keyword], APIError>) in
            completion(result)
        }
    }
}
