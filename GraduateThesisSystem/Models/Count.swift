//
//  Count.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 25.12.2023.
//

import Foundation

struct Count: Codable {
    let authorsCount, institutesCount, languagesCount, supervisorsCount: Int
    let thesesCount, universitiesCount, locationsCount, subjectTopicsCount, keywordsCount: Int
    
    init() {
        authorsCount = 0
        institutesCount = 0
        languagesCount = 0
        supervisorsCount = 0
        thesesCount = 0
        universitiesCount = 0
        locationsCount = 0
        subjectTopicsCount = 0
        keywordsCount = 0
    }
    
}
