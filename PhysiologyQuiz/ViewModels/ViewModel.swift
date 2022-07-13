//
//  QuestionsViewModel.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 11/07/22.
//

import SwiftUI
import Combine

class ViewModel: ObservableObject {
    @Published var settings = SettingsViewModel()

    @Published private(set) var questions: Questions = []
    @Published private(set) var selectedQuestions: Questions = []
    @Published var counter: Int = 0
    
    var answeredIndexes: Set<Int> {
        Set(selectedQuestions.enumerated().filter { $0.element.value != nil }.map { $0.offset })
    }
    
    var currentQuestion: Question {
        get { selectedQuestions[counter] }
        set { selectedQuestions[counter] = newValue }
    }

    var nonGivenAnswers: Questions {
        selectedQuestions.filter { q in
            q.value == nil
        }
    }
    
    var correctAnswers: Questions {
        selectedQuestions.filter { q in
            q.value != nil && q.value! == q.answer
        }
    }

    var wrongAnswers: Questions {
        selectedQuestions.filter { q in
            q.value != nil && q.value! != q.answer
        }
    }
    
    var anyCancellable: AnyCancellable? = nil
    
    init(_ filename: String, _ `extension`: String) {
        anyCancellable = settings.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }

        load(filename, `extension`)
        resetQuiz()
    }

    
    func load(_ filename: String, _ `extension`: String) {
        
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: `extension`)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            questions = try decoder.decode(Questions.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Questions.self):\n\(error)")
        }
    }
    
    private func extractQuestions() {
        let questionsCount = questions.count
        // extract n random questions
        for _ in 0..<settings.numberOfQuestions {
            selectedQuestions.append(questions[Int.random(in: 0..<questionsCount)])
        }
    }
    
    func answerQuestionAt(value: Bool) {
        if currentQuestion.value == value {
            currentQuestion.value = nil
        } else {
            currentQuestion.value = value
        }
        skipQuestions(1)
    }
    
    func skipQuestions(_ v: Int) {
        if v > 0 && counter + v < settings.numberOfQuestions {
            counter += v
        } else if v < 0 && counter - abs(v) >= 0 {
            counter -= abs(v)
        }
    }
    
    func resetQuiz() {
        selectedQuestions = []
        counter = 0
        extractQuestions()
    }
}
