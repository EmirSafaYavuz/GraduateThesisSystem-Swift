//
//  University.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import Foundation

struct University: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let locationId: Int
    let city: String
    let country: String
}

struct UniversityInput: Codable {
    let id: Int
    let name: String
    let locationId: Int
}
