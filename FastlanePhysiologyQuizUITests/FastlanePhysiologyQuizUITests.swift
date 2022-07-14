//
//  FastlanePhysiologyQuizUI.swift
//  FastlanePhysiologyQuizUI
//
//  Created by Federico Ciardi on 14/07/22.
//

import XCTest

class FastlanePhysiologyQuizUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = true
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    func testScreenshots() throws {
        snapshot("01HomeScreen")
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.buttons["startQuiz"]/*[[".buttons[\"Inizia\"]",".buttons[\"startQuiz\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("02QuizScreen")
        let truebuttonButton = app/*@START_MENU_TOKEN@*/.buttons["trueButton"]/*[[".buttons[\"Selezionato\"]",".buttons[\"trueButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        for _ in 1..<9 {
            truebuttonButton.tap()
        }
        let ttgc7swiftui19uihostingNavigationBar = app.navigationBars["_TtGC7SwiftUI19UIHosting"]
        ttgc7swiftui19uihostingNavigationBar/*@START_MENU_TOKEN@*/.buttons["submitButton"]/*[[".buttons[\"Vai All'inizio\"]",".buttons[\"submitButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("03SubmittedQuizScreen")
        app/*@START_MENU_TOKEN@*/.buttons["showResultsButton"]/*[[".buttons[\"Mostra punteggi\"]",".buttons[\"showResultsButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("04QuizResultsScreen")
        app.navigationBars["Punteggi"]/*@START_MENU_TOKEN@*/.buttons["closeButton"]/*[[".buttons[\"Fine\"]",".buttons[\"closeButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        ttgc7swiftui19uihostingNavigationBar.buttons["Quiz fisiologia"].tap()
        app.navigationBars["Quiz fisiologia"]/*@START_MENU_TOKEN@*/.buttons["allQuestionsButton"]/*[[".buttons[\"Elenco\"]",".buttons[\"allQuestionsButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("05QuizzesScreen")
    }

}
