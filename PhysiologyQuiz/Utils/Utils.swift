//
//  Utils.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 14/07/22.
//

import Foundation

func emailURL(subject: String = "") -> URL {
    let _subject = "Quiz fisiologia" + (subject.count > 0 ? " - \(subject)" : subject)
    return URL(string: "mailto:fed.ciardi+quiz-fisiologia@gmail.com?subject=\(_subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")!
}

