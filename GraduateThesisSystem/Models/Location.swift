//
//  Location.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import Foundation

struct Location: Codable, Identifiable, Hashable {
    let id: Int
    let city: String
    let country: String
}
