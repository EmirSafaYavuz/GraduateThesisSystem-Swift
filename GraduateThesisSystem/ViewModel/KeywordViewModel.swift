//
//  KeywordViewModel.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 27.12.2023.
//

import Foundation

class KeywordViewModel: ObservableObject {
    @Published var keywords: [Keyword] = []
    @Published var thesesOfKeyword: [Thesis] = []
    
    func getAllKeywords() {
        KeywordAPI.getAllKeywords { result in
            switch result {
            case .success(let fetchedKeywords):
                DispatchQueue.main.async {
                    self.keywords = fetchedKeywords
                }
            case .failure(let error):
                print("Error loading keywords: \(error)")
            }
        }
    }
    
    func getKeyword(with keywordId: Int) {
        KeywordAPI.getKeyword(with: keywordId) { result in
            switch result {
            case .success(let fetchedKeyword):
                DispatchQueue.main.async {
                    self.keywords.append(fetchedKeyword)
                }
            case .failure(let error):
                print("Error loading keyword: \(error)")
            }
        }
    }
    
    func getThesesKeywords(with thesisId: Int) {
        KeywordAPI.getThesesByKeyword(with: thesisId) { result in
            switch result {
            case .success(let fetchedKeywords):
                DispatchQueue.main.async {
                    self.thesesOfKeyword = fetchedKeywords
                }
            case .failure(let error):
                print("Error loading keywords: \(error)")
            }
        }
    }
    
    func addKeyword(keyword: Keyword) {
        KeywordAPI.addKeyword(keyword: keyword) { result in
            switch result {
            case .success(let addedKeyword):
                DispatchQueue.main.async {
                    self.keywords.append(addedKeyword)
                }
            case .failure(let error):
                print("Error adding keyword: \(error)")
            }
        }
    }
    
    func deleteKeyword(with keywordId: Int?) {
        guard let keywordId = keywordId else {
            print("Keyword id is nil, cannot delete.")
            return
        }
        
        KeywordAPI.deleteKeyword(with: keywordId) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.keywords.removeAll { $0.id == keywordId }
                }
            case .failure(let error):
                print("Error deleting keyword: \(error)")
            }
        }
    }
}
