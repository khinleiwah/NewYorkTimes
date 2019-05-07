//
//  NewYorkTimesTests.swift
//  NewYorkTimesTests
//
//  Created by Win on 4/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class NewYorkTimesTests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app.terminate()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let collectionView = app.collectionViews.element(boundBy: 0)
//        expectation(for: exists, evaluatedWith: collectionView.cells.firstMatch, handler: nil)
//        waitForExpectations(timeout: 20, handler: nil)
        self.waitForElementToAppear(collectionView)
        print("expect count : \(collectionView.cells.count)")
        XCTAssertGreaterThan(collectionView.cells.count, 0, "should greater than 0")

        let search = app.collectionViews.searchFields["Search"]
        search.tap()
        search.typeText("Singapore")
        print("search count : \(collectionView.cells.count)")
        if(app.collectionViews.cells.count > 0) {
            app.collectionViews.cells.firstMatch.tap()
        }

//        app.collectionViews.searchFields["Search"].tap()
//        let search = app
//            .otherElements["CollectionViewID"]
//            .children(matching: .searchField)
//            .element
//        //Click in here
//        search.tap()
//
//        search.typeText("Singapore")
//        app.keyboards.buttons["Search"].tap()
   }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
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
}
