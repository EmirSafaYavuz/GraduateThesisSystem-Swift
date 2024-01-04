//
//  ThesisType.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 31.12.2023.
//

import Foundation

enum ThesisType: String, CaseIterable, Identifiable, Hashable {
    case master = "Master"
    case doctorate = "Doctorate"
    case specializationInMedicine = "Specialization in Medicine"
    case proficiencyInArt = "Proficiency in Art"
    
    var id: String { self.rawValue }
}

extension ThesisType {
    func toString() -> String {
        return self.rawValue
    }
}

extension ThesisType {
    var index: Int {
        switch self {
        case .master:
            return 0
        case .doctorate:
            return 1
        case .specializationInMedicine:
            return 2
        case .proficiencyInArt:
            return 3
        }
    }
}
