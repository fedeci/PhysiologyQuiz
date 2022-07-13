//
//  QuestionDetailView.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 11/07/22.
//

import SwiftUI

struct QuestionDetailView: View {
    var question: Question

    var body: some View {
        List {
            Section("Domanda") {
                Text(question.question)
            }
            if let value = question.value {
                Section("Risposta Data") {
                    Text(value ? "Vero" : "Falso")
                }
            }
            Section("Risposta Corretta") {
                Text(question.answer ? "Vero" : "Falso")
                    .bold()
            }
            if let details = question.details, details.count > 0 {
                Section("Dettagli") {
                    Text(details)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct QuestionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionDetailView(question: Question(question: "Some very very very very very, very very very very very, very very very very very, very very very very very long question question", answer: false, details: "Some details", value: false))
    }
}
