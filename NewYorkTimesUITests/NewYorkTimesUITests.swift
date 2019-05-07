//
//  NewYorkTimesUITests.swift
//  NewYorkTimesUITests
//
//  Created by Win on 4/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class NewYorkTimesUITests: XCTestCase {
    
    var app: XCUIApplication!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
       
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
         app = XCUIApplication()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
   
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func waitForElementToAppear(_ element: XCUIElement, file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: 5) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after 5 seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: Int(line), expected: true)
            }
        }
    }
    
    func testElementExists() {
        app.launch()
        
        let collectionView = app.collectionViews.element(boundBy: 0)
        XCTAssert(collectionView.exists)
        
        let search = app.collectionViews.searchFields["Search"]
        XCTAssert(search.exists)
        
        self.waitForElementToAppear(collectionView.cells.firstMatch)
     
        app.collectionViews.element.swipeUp()
        
        XCTAssert(collectionView.cells.staticTexts["titleId"].exists)
        XCTAssert(collectionView.cells.staticTexts["snippetId"].exists)
        XCTAssert(collectionView.cells.staticTexts["dateId"].exists)
        
        if(collectionView.cells.count > 0) {
            collectionView.cells.element(boundBy: 0).tap()
        }
        
        let webView = app.otherElements["webViewId"]
        self.waitForElementToAppear(webView)
        XCTAssert(app.navigationBars["Detail News"].exists)
        XCTAssert(webView.exists)
        
        webView.swipeLeft()
        sleep(5)
        webView.swipeRight()
    }
    
    
    
//    func testTextExistsInAWebView() {
//        app.buttons["More Info"].tap()
//        let volleyballLabel = app.staticTexts["Volleyball"]
//        waitForElementToAppear(volleyballLabel)
//        XCTAssert(volleyballLabel.exists)
//    }
    
//    func testElementExists() {
//
//
//
//
//
//        //        let label = app.staticTexts["Detail News"]
//        //let exists = NSPredicate(format: "exists == true")
////        expectation(for: exists, evaluatedWith: label, handler: nil)
////        waitForExpectations(timeout: 5, handler: nil)
////        XCTAssert(label.exists)
//
////        XCTAssert(XCUIApplication().staticTexts["Detail News"].exists)
//
//        //let collectionViewCell = app.collectionViews.cells
//
////         XCTAssertEqual(app.collectionViews.cells.count, app.collectionViews.element.children(matching: .cell).count)
//
//    }
////    func testExample() {
////        // Use recording to get started writing UI tests.
////        // Use XCTAssert and related functions to verify your tests produce the correct results.
////        app.launch()
////
////
////        //print("count \(app.collectionViews.element.children(matching: .cell).count)")
//////        app.collectionViews.element.swipeUp()
//////        print("count \(app.collectionViews.element.children(matching: .cell).count)")
//////        XCTAssertEqual(app.collectionViews.cells.count, 3)
////
////
////        let collectionView = app.collectionViews
////        let exists = NSPredicate(format: "exists == true")
////
////        expectation(for: exists, evaluatedWith: collectionView.cells.firstMatch, handler: nil)
////        waitForExpectations(timeout: 20, handler: nil)
////        print("expect count : \(collectionView.cells.count)")
////        XCTAssertGreaterThan(collectionView.cells.count, 0, "should greater than 0")
////
////        let search = app.collectionViews.searchFields["Search"]
////        search.tap()
////        search.typeText("Singapore")
////        print("search count : \(collectionView.cells.count)")
////        if(app.collectionViews.cells.count > 0) {
////            app.collectionViews.cells.firstMatch.tap()
////        }
//
//        //app.collectionViews.searchFields["Search"].tap()
////        let search = app
////            .otherElements["CollectionViewID"]
////            .children(matching: .searchField)
////            .element
////        //Click in here
////        search.tap()
////
////        search.typeText("Singapore")
////        app.keyboards.buttons["Search"].tap()
//
//
//
////        let isDisplayingOnboarding = app.otherElements["Onboarding View"].exists
////
////        let firstChild = app.collectionViews.children(matching:.any).element(boundBy: 0)
////        if firstChild.exists {
////            firstChild.tap()
////        }
//        //        XCTAssertTrue(isDisplayingOnboarding)
//        //        XCTAssertEqual(app.staticTexts.element(boundBy: 0).value as! String, "January")
//        //        app.swipeLeft()
//        //        XCTAssertEqual(app.staticTexts.element(boundBy: 0).value as! String, "February")
//        //        app.swipeLeft()
//        //        XCTAssertEqual(app.staticTexts.element(boundBy: 0).value as! String, "March")
//        //        app.terminate()
////    }

}
