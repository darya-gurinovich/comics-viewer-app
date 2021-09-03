//
//  ComicsXkcdSourceTests.swift
//  ComicsViewerAppTests
//
//  Created by Dasha Gurinovich on 3.09.21.
//

@testable import ComicsViewerApp
import XCTest

class ComicsXkcdSourceTests: ComicsSourceTests {
    
    private var xkcdSource = ComicsXkcdSource()
    override var comicsSource: ComicsSource! {
        get {
            xkcdSource
        }
        set {
            if let xkcdSource = newValue as? ComicsXkcdSource {
                self.xkcdSource = xkcdSource
            }
        }
        
    }
    
}
