//
//  NewYorkTimesUnitTests.swift
//  NewYorkTimesTests
//
//  Created by Win on 6/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class NewYorkTimesUnitTests: XCTestCase {
    
    var homeVC: HomeCollectionViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        homeVC = storyboard.instantiateInitialViewController() as? HomeCollectionViewController
        
        UIApplication.shared.keyWindow!.rootViewController = homeVC
        
        XCTAssertNotNil(homeVC.view)
        XCTAssertNotNil(homeVC.activityView)
        XCTAssertNotNil(homeVC.collectionView)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testElement() {
        //1 Arrange
        let fakeArticles = [Article.init(web_url: "www.google.com", _id: "1", byline: Byline.init(), document_type: nil, headline: Headline.init(content_kicker: "aa", kicker: nil, main: "Good Morning", name: "hello", print_headline: "Welcome", seo: nil, sub: nil), keywords: nil, multimedia: [Multimedia.init(rank: 0, subtype: nil, caption: "caption", credit: nil, type: nil, url: "https://i.pinimg.com/474x/35/be/d6/35bed642ba4ef8a4d4c80adf50d418fb.jpg", height: nil, width: nil, legacy: nil, subType: nil, crop_name: nil)], news_desk: nil, print_page: nil, pub_date: "06May2019", score: nil, snippet: nil, source: nil, type_of_material: nil, uri: nil, word_count: nil)]
     
        homeVC.articles = fakeArticles
        
        //2 Act
        homeVC.collectionView.reloadData()
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.5))
        
        //3 Assert
        let cells = homeVC.collectionView.visibleCells as! [HomeImageCollectionViewCell]
        XCTAssertEqual(cells.count, fakeArticles.count, "Cells count should match array.count")
       
        print("cells count \(cells.count)")
        XCTAssertGreaterThan(cells.count, 0, "Greater than zero")
        
        for i in 0...cells.count - 1 {
            let cell = cells[i]
            XCTAssertEqual(cell.imageView.image, UIImage(named: (fakeArticles[i].multimedia?.last?.url)!), "Image should be matching")
        }
        
        homeVC.searchRecords(searchText: "morning")
        XCTAssertEqual(cells.count, homeVC.articles.count, "Cells count should match array.count")
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            homeVC.searchRecords(searchText: "Morning")
        }
    }
    
//    func waitForElementToAppear(_ element: XCUIElement, file: String = #file, line: UInt = #line) {
//        let existsPredicate = NSPredicate(format: "exists == true")
//        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
//
//        waitForExpectations(timeout: 5) { (error) -> Void in
//            if (error != nil) {
//                let message = "Failed to find \(element) after 5 seconds."
//                self.recordFailure(withDescription: message, inFile: file, atLine: Int(line), expected: true)
//            }
//        }
//    }
}
