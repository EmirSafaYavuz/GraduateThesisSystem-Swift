//
//  SubjectTopicViewModel.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 23.12.2023.
//

import Foundation

class SubjectTopicViewModel: ObservableObject {
    @Published var subjectTopics: [SubjectTopic] = []
    
    func getAllSubjectTopics() {
        SubjectTopicAPI.getAllSubjectTopics { result in
            switch result {
            case .success(let fetchedSubjectTopics):
                DispatchQueue.main.async {
                    self.subjectTopics = fetchedSubjectTopics
                }
            case .failure(let error):
                print("Error loading subject topics: \(error)")
            }
        }
    }
    
    func addSubjectTopic(subjectTopic: SubjectTopic) {
        SubjectTopicAPI.addSubjectTopic(subjectTopic: subjectTopic) { result in
            switch result {
            case .success(let addedSubjectTopic):
                DispatchQueue.main.async {
                    self.subjectTopics.append(addedSubjectTopic)
                }
            case .failure(let error):
                print("Error adding subject topic: \(error)")
            }
        }
    }
    
    func deleteSubjectTopic(with subjectTopicId: Int?) {
        guard let subjectTopicId = subjectTopicId else {
            print("Subject topic id is nil, cannot delete.")
            return
        }
        
        SubjectTopicAPI.deleteSubjectTopic(with: subjectTopicId) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.subjectTopics.removeAll { $0.id == subjectTopicId }
                }
            case .failure(let error):
                print("Error deleting subject topic: \(error)")
            }
        }
    }
}
