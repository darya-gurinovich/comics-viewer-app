import XCTest
@testable import XkcdComicsKit

final class XkcdComicsKitTests: XCTestCase {
    private let expectationsWait = 5.0
    
    // MARK: Current Comic
    
    func testCurrentComicFetch() {
        let promise = expectation(description: "Comic Fetch Response")
        
        XkcdComicsKit.default.fetchCurrentComic { comic, error in
            XCTAssertNil(error, "Error: \(error?.localizedDescription ?? "")")
            XCTAssertNotNil(comic, "Response shouldn't have been empty")
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: expectationsWait, handler: nil)
    }
    
    // MARK: First Comic
    
    func testFirstComicFetch() {
        let promise = expectation(description: "Comic Fetch Response")
        
        XkcdComicsKit.default.fetchFirstComic { comic, error in
            XCTAssertNil(error, "Error: \(error?.localizedDescription ?? "")")
            XCTAssertNotNil(comic, "Response shouldn't have been empty")
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: expectationsWait, handler: nil)
    }
    
    // MARK: Previous Comic
    
    func testNoPreviousComicFetch() {
        // Need to fetch the first comic so the previous is unavailable
        testFirstComicFetch()
        
        let promise = expectation(description: "Comic Fetch Response")
        
        XkcdComicsKit.default.fetchPreviousComic { comic, error in
            XCTAssertEqual(error as? XkcdComicError, XkcdComicError.noPreviousComic)
            XCTAssertNil(comic, "Response should have been empty")
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: expectationsWait, handler: nil)
    }
    
    func testPreviousComicFetch() {
        // Need to fetch the latest comic number to get the previous
        testLatestComicFetch()
        
        let promise = expectation(description: "Comic Fetch Response")
        
        XkcdComicsKit.default.fetchPreviousComic { comic, error in
            XCTAssertNil(error, "Error: \(error?.localizedDescription ?? "")")
            XCTAssertNotNil(comic, "Response shouldn't have been empty")
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: expectationsWait, handler: nil)
    }
    
    // MARK: Next Comic
    
    func testNoNextComicFetch() {
        // Need to fetch the latest comic so the next is unavailable
        testLatestComicFetch()
        
        let promise = expectation(description: "Comic Fetch Response")
        
        XkcdComicsKit.default.fetchNextComic { comic, error in
            XCTAssertEqual(error as? XkcdComicError, XkcdComicError.noNextComic)
            XCTAssertNil(comic, "Response should have been empty")
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: expectationsWait, handler: nil)
    }
    
    func testNextComicFetch() {
        // Need to fetch the first comic so the next is available
        testFirstComicFetch()
        
        let promise = expectation(description: "Comic Fetch Response")
        
        XkcdComicsKit.default.fetchNextComic { comic, error in
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
        
        XkcdComicsKit.default.fetchLatestComic { comic, error in
            XCTAssertNil(error, "Error: \(error?.localizedDescription ?? "")")
            XCTAssertNotNil(comic, "Response shouldn't have been empty")
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: expectationsWait, handler: nil)
    }
}
