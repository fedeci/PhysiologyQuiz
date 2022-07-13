//
//  SettingsView.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 12/07/22.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        List {
            Section("Numero di domande") {
                Stepper(value: viewModel.settings.$numberOfQuestions, in: 1...200) {
                    Text("Numero di domande: \(viewModel.settings.numberOfQuestions)")
                }
            }
            Section("Punteggi") {
                Stepper(value: viewModel.settings.$correctAnswer, in: 0...2, step: 0.05) {
                    Text("Punteggio risposte corrette: \(viewModel.settings.correctAnswer, specifier: "%.2f")")
                }
                Stepper(value: viewModel.settings.$wrongAnswer, in: -2...2, step: 0.05) {
                    Text(String(format: "Punteggio risposte errate: %.2f", viewModel.settings.wrongAnswer))
                }
                Stepper(value: viewModel.settings.$nonGivenAnswer, in: -2...2, step: 0.05) {
                    Text(String(format: "Punteggio risposte non date: %.2f", viewModel.settings.nonGivenAnswer))
                }
            }
        }
        .navigationTitle(Text("Impostazioni"))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: ViewModel("questions", "json"))
    }
}
