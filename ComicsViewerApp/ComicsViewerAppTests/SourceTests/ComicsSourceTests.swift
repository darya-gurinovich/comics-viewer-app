//
//  ComicsSourceTests.swift
//  ComicsViewerAppTests
//
//  Created by Dasha Gurinovich on 3.09.21.
//

@testable import ComicsViewerApp
import XCTest

class ComicsSourceTests: BaseComicsViewerAppTests {
    
    private let expectationsWait = 5.0
    var comicsSource: ComicsSource!
    
    override func setUp() {
        super.setUp()
        
        try? XCTSkipIf(comicsSource == nil)
    }
    
    // MARK: Current Comic
    
    func testCurrentComicFetch() {
        let promise = expectation(description: "Comic Fetch Response")
        
        comicsSource.fetchCurrentComic { comic, error in
            XCTAssertNil(error, "Error: \(error?.localizedDescription ?? "")")
            XCTAssertNotNil(comic, "Response shouldn't have been empty")
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: expectationsWait, handler: nil)
    }
    
    // MARK: First Comic
    
    func testFirstComicFetch() {
        let promise = expectation(description: "Comic Fetch Response")
        
        comicsSource.fetchFirstComic { comic, error in
            XCTAssertNil(error, "Error: \(error?.localizedDescription ?? "")")
            XCTAssertNotNil(comic, "Response shouldn't have been empty")
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: expectationsWait, handler: nil)
    }
    
    // MARK: Previous Comic
    
    func testPreviousComicFetch() {
        // Need to fetch the latest comic number to get the previous
        testLatestComicFetch()
        
        let promise = expectation(description: "Comic Fetch Response")
        
        comicsSource.fetchPreviousComic { comic, error in
            XCTAssertNil(error, "Error: \(error?.localizedDescription ?? "")")
            XCTAssertNotNil(comic, "Response shouldn't have been empty")
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: expectationsWait, handler: nil)
    }
    
    // MARK: Next Comic
    
    func testNextComicFetch() {
        // Need to fetch the first comic so the next is available
        testFirstComicFetch()
        
        let promise = expectation(description: "Comic Fetch Response")
        
        comicsSource.fetchNextComic { comic, error in
            XCTAssertNil(error, "Error: \(error?.localizedDescription ?? "")")
            XCTAssertNotNil(comic, "Response shouldn't have been empty")
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: expectationsWait, handler: nil)
    }
    
    // MARK: Latest Comic
    
    func testLatestComicFetch() {
        testCurrentComicFetch()
        
        let promise = expectation(description: "Comic Fetch Response")
        
        comicsSource.fetchLatestComic { comic, error in
            XCTAssertNil(error, "Error: \(error?.localizedDescription ?? "")")
            XCTAssertNotNil(comic, "Response shouldn't have been empty")
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: expectationsWait, handler: nil)
    }

}
