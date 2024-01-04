//
//  Institute.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import Foundation

struct Institute: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let universityId: Int
    let universityName: String
}
