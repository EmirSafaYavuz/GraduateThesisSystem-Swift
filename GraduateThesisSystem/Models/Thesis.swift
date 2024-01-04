//
//  Thesis.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import Foundation

struct Thesis: Codable, Identifiable, Hashable {
    let id: Int
    var thesisNo: Int
    var title: String
    var abstract: String
    var year: Int
    var numOfPages: Int
    var submissionDate: String
    var authorId: Int
    var authorName: String
    var languageId: Int
    var languageName: String
    var coSupervisorId: Int?
    var coSupervisorName: String?
    var instituteId: Int
    var instituteName: String
    var supervisorId: Int
    var supervisorName: String
    var thesisType: String
}


struct ThesisInput: Codable {
    var thesisNo: Int
    var title: String
    var abstract: String
    var year: Int
    var numOfPages: Int
    var authorId: Int
    var languageId: Int
    var coSupervisorId: Int?
    var instituteId: Int
    var supervisorId: Int
    var thesisType: Int
    var supervisorIdList: [Int]
}
