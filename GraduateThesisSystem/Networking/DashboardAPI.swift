//
//  DashboardAPI.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 25.12.2023.
//

import Foundation

struct DashboardAPI {
    static var statisticsUrl: URL {
        if let customBaseUrl = ProcessInfo.processInfo.environment["CUSTOM_BASE_URL"] {
            return URL(string: customBaseUrl + "/Statistics")!
        } else {
            return URL(string: "")!
        }
    }
    
    static func getCounts(completion: @escaping (Result<Count, APIError>) -> Void) {
        let countsUrl = statisticsUrl.appendingPathComponent("GetCounts")
        
        APIManager.shared.fetchData(url: countsUrl) { result in
            completion(result)
        }
    }
}
