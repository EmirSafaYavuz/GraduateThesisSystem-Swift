//
//  Author.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import Foundation

struct Author: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let email: String
}

extension Author {
    static let sampleData: [Author] = [
        Author(id: 1, name: "Emir Safa", email: "emirsafayavuz@gmail.com"),
        Author(id: 2, name: "Yağmur Demiröz", email: "ydmrzz03@gmail.com"),
    ]
}
