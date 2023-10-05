//
//  TestUtils.swift
//  FastlanePhysiologyQuizUITests
//
//  Created by Federico Ciardi on 09/02/23.
//

import XCTest

extension XCUIElement {
    func forceTap() {
        if isHittable {
            tap()
        }
        else {
            let coordinate: XCUICoordinate = coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
            coordinate.tap()
        }
    }
}
