//
//  UITestingBootcampView_UITests.swift
//  SwiftfulThings_UITests
//
//  Created by Yan Rodrigues on 18/10/24.
//

import XCTest

final class UITestingBootcampView_UITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
    }

    func test_UITestinBootcampView_signUpButton_shouldNotSignIn() {
        //Given
        let textfield = app.textFields["SignUpTextfield"]
        
        //When
        textfield.tap()

        let returnButton = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"retorno\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        returnButton.tap()
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
        
        let navBar = app.navigationBars["Welcome"]
        
        //THen
        XCTAssertFalse(navBar.exists)
    }
    
    func test_UITestinBootcampView_signUpButton_shouldSignIn() {
        //Given
        let textfield = app.textFields["SignUpTextfield"]
        
        //When
        textfield.tap()
        let keyA = app.keys["A"]
        keyA.tap()
        let keya = app.keys["a"]
        keya.tap()
        keya.tap()
        
        let returnButton = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"retorno\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        returnButton.tap()
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
        
        let navBar = app.navigationBars["Welcome"]
        
        //THen
        XCTAssertTrue(navBar.exists)
                
    }
    
    func test_SignedInHomeView_showAlertButton_shouldDisplayAlert() {
        //Given
        let textfield = app.textFields["SignUpTextfield"]
        
        //When
        textfield.tap()
        let keyA = app.keys["A"]
        keyA.tap()
        let keya = app.keys["a"]
        keya.tap()
        keya.tap()
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
        
        let navBar = app.navigationBars["Welcome"]
        XCTAssertTrue(navBar.exists)
        
        let alertButton = app.buttons["ShowAlertButton"]
        alertButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
    }
    
    func test_SignedInHomeView_showAlertButton_shouldDisplayAndDismissAlert() {
        //Given
        let textfield = app.textFields["SignUpTextfield"]
        
        //When
        textfield.tap()
        let keyA = app.keys["A"]
        keyA.tap()
        let keya = app.keys["a"]
        keya.tap()
        keya.tap()
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
        
        let navBar = app.navigationBars["Welcome"]
        XCTAssertTrue(navBar.exists)
        
        let alertButton = app.buttons["ShowAlertButton"]
        alertButton.tap()
        
        let alert = app.alerts.firstMatch
        
        let alertOkButton = alert.buttons["OK"]
        XCTAssertTrue(alertOkButton.exists)
        let exists = alertOkButton.waitForExistence(timeout: 2)

        XCTAssertTrue(exists)
        alertOkButton.tap()
        let alertExists = alert.waitForExistence(timeout: 2)
        
        //THen
        XCTAssertFalse(alertExists)
        XCTAssertFalse(alert.exists)
    }
    
    func test_SignedInHomeView_navigationLinkToDestination_shouldNavigateToDestination() {
        //Given
        let textfield = app.textFields["SignUpTextfield"]
        
        //When
        textfield.tap()
        let keyA = app.keys["A"]
        keyA.tap()
        let keya = app.keys["a"]
        keya.tap()
        keya.tap()
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
        
        let navBar = app.navigationBars["Welcome"]
        XCTAssertTrue(navBar.exists)
        
        let navLinkButton = app/*@START_MENU_TOKEN@*/.buttons["NavigationLinkToDestination"]/*[[".buttons[\"Navigate\"]",".buttons[\"NavigationLinkToDestination\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        navLinkButton.tap()
        
        let destinationText = app.staticTexts["Destination"]
        
        XCTAssertTrue(destinationText.exists)
    }
    
    func test_SignedInHomeView_navigationLinkToDestination_shouldNavigateToDestinationAndGoBack() {
        //Given
        let textfield = app.textFields["SignUpTextfield"]
        
        //When
        textfield.tap()
        let keyA = app.keys["A"]
        keyA.tap()
        let keya = app.keys["a"]
        keya.tap()
        keya.tap()
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
        
        let navBar = app.navigationBars["Welcome"]
        XCTAssertTrue(navBar.exists)
        
        let navLinkButton = app/*@START_MENU_TOKEN@*/.buttons["NavigationLinkToDestination"]/*[[".buttons[\"Navigate\"]",".buttons[\"NavigationLinkToDestination\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        navLinkButton.tap()
        
        let destinationText = app.staticTexts["Destination"]
        
        XCTAssertTrue(destinationText.exists)
        
        let backbutton = app.navigationBars.buttons["Welcome"]
        backbutton.tap()
        
        XCTAssertTrue(navBar.exists)
        
    }
}
