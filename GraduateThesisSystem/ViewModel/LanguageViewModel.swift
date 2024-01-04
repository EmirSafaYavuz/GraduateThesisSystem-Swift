//
//  LanguageViewModel.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 22.12.2023.
//

import Foundation

class LanguageViewModel: ObservableObject {
    @Published var languages: [Language] = []
    
    func getAllLanguages() {
        LanguageAPI.getAllLanguages { result in
            switch result {
            case .success(let fetchedLanguages):
                DispatchQueue.main.async {
                    self.languages = fetchedLanguages
                }
            case .failure(let error):
                print("Error loading languages: \(error)")
            }
        }
    }
    
    func addLanguage(language: Language) {
        LanguageAPI.addLanguage(language: language) { result in
            switch result {
            case .success(let addedLanguage):
                DispatchQueue.main.async {
                    self.languages.append(addedLanguage)
                }
            case .failure(let error):
                print("Error adding language: \(error)")
            }
        }
    }
    
    func deleteLanguage(with languageId: Int?) {
        guard let languageId = languageId else {
            print("Language id is nil, cannot delete.")
            return
        }
        
        LanguageAPI.deleteLanguage(with: languageId) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.languages.removeAll { $0.id == languageId }
                }
            case .failure(let error):
                print("Error deleting language: \(error)")
            }
        }
    }
}
