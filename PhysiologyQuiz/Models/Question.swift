//
//  Model.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 11/07/22.
//

import Foundation

typealias QuestionsData = [QuestionsGroup]

struct QuestionsGroup: Codable, Hashable {
    var name: String
    var questions: Questions
}

typealias Questions = [Question]

struct Question: Codable, Hashable {
    let question: String
    let answer: Bool
    var details: String?
    var value: Bool?

    private enum CodingKeys: String, CodingKey {
        case question
        case answer
        case details
    }
}
