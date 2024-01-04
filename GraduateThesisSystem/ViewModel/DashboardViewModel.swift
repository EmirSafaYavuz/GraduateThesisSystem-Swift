//
//  DashboardViewModel.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 25.12.2023.
//

import Foundation

class DashboardViewModel: ObservableObject {
    @Published var counts: Count = Count.init()
    
    func getCounts() {
        DashboardAPI.getCounts { result in
            switch result {
            case .success(let fetchedCounts):
                DispatchQueue.main.async {
                    self.counts = fetchedCounts
                }
            case .failure(let error):
                print("Error loading counts: \(error)")
            }
        }
    }
}
