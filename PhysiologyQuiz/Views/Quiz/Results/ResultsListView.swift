//
//  ResultsListView.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 13/07/22.
//

import SwiftUI

struct ResultsListView: View {
    @State private var searchQuery: String = ""

    var title: String
    var questions: Questions

    var body: some View {
        List(searchResults, id: \.self, rowContent: { q in
            NavigationLink {
                QuestionDetailView(question: q)
            } label: {
                Text(q.question)
                    .bold()
                    .lineLimit(2)
                .frame(height: 60)
            }
        })
            .navigationTitle(Text(title))
            .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always))
    }

    var searchResults: Questions {
        if searchQuery.isEmpty {
            return questions
        } else {
            return questions.filter { question in
                if question.question.localizedCaseInsensitiveContains(searchQuery) {
                    return true
                }
                if let details = question.details, details.localizedCaseInsensitiveContains(searchQuery) {
                    return true
                }
                return false
            }
        }
    }
}

struct ResultsListView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsListView(title: "Risposte corrette", questions: [Question(question: "Foo foo fo fo ofo ofo fo ofo fof ofo ofo foo fo fofo ofofo", answer: false), Question(question: "Foo", answer: true)])
    }
}
