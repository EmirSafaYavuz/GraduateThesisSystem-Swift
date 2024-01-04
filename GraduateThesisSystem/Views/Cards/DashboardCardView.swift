//
//  DashboardCardView.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 16.12.2023.
//

import SwiftUI

struct DashboardCardView: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                Text("\(value) Records")
                    .font(.body)
                Spacer()
            }
            .font(.caption)
        }
        .padding()
    }
}

#Preview {
    DashboardCardView(title: "Author", value: "5")
}
