//
//  Screenshots.swift
//  Screenshots
//
//  Created by Zev Eisenberg on 6/3/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//

import XCTest

class Screenshots: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        XCUIDevice.shared.orientation = .portrait
    }

    func testTakeScreenshots() {
        snapshot("1 - agenda")
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Team"].tap()
        snapshot("2 - team")

        XCUIApplication().tabBars.buttons["Speakers"].tap()
        XCUIApplication().tabBars.buttons["Speakers"].tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["The Simple Layout of a Complex Interface"]/*[[".cells.staticTexts[\"The Simple Layout of a Complex Interface\"]",".staticTexts[\"The Simple Layout of a Complex Interface\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("3 - speaker")

        XCUIApplication().tabBars.buttons["Agenda"].tap()
        XCUIApplication().tables.cells.containing(.staticText, identifier: "The Simple Layout of a Complex Interface").staticTexts["Agnes Vasarhelyi"].tap()
        snapshot("4 - session")
    }
    
}
