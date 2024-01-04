//
//  ThesisCard.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 25.12.2023.
//

import SwiftUI

struct ThesisCard: View {
    var title: String
    var author: String
    var thesisNo: String
    var thesisType: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
                .lineLimit(2)
                .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
            Spacer()
            Text(thesisType)
            HStack {
                Text(author)
                    .font(.body)
                Spacer()
                Text(thesisNo)
            }
            .font(.caption)
        }
        .padding()
    }
}

#Preview {
    ThesisCard(title: "Thesis", author: "Author", thesisNo: "795132", thesisType: "Master")
}
