//
//  TinyKitUITests.swift
//  TinyKitUITests
//
//  Created by Roy Hsu on 2019/3/16.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

import XCTest

final class TinyKitUITests: XCTestCase {

    override func setUp() {
        
        continueAfterFailure = false

        let application = XCUIApplication()
        
        application.launchEnvironment["environment"] = "testing"
        
        application.launch()

    }

    func testAuthorize() {
        
        let application = XCUIApplication()
        
        let authorizeButton = application.buttons["Authorize"].firstMatch
        
        let signUpButton = application.buttons["Sign Up"].firstMatch
        
        XCTContext.runActivity(named: "Start authorizing.") { activity in
            
            authorizeButton.tap()
            
        }
        
        XCTContext.runActivity(named: "Sign up.") { activity in
            
            signUpButton.tap()
            
        }
        
    }

}
