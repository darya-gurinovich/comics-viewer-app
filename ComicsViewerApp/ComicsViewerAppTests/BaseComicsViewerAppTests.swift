//
//  ComicsViewerAppTests.swift
//  ComicsViewerAppTests
//
//  Created by Dasha Gurinovich on 3.09.21.
//

import XCTest
import RealmSwift

class BaseComicsViewerAppTests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        // Use a separate database for each test
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }

}
