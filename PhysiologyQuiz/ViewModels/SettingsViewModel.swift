//
//  SettingsViewModel.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 12/07/22.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @AppStorage(Keys.numberOfQuestions.rawValue) var numberOfQuestions: Int = 60
    @AppStorage(Keys.nonGivenAnswerPoints.rawValue) var nonGivenAnswer: Double = 0
    @AppStorage(Keys.correctAnswerPoints.rawValue) var correctAnswer: Double = 1
    @AppStorage(Keys.wrongAnswerPoints.rawValue) var wrongAnswer: Double = -0.5

    enum Keys: String {
        case numberOfQuestions
        case nonGivenAnswerPoints
        case correctAnswerPoints
        case wrongAnswerPoints
    }
}
