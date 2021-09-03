//
//  ComicsStorageSourceTests.swift
//  ComicsViewerAppTests
//
//  Created by Dasha Gurinovich on 3.09.21.
//


@testable import ComicsViewerApp
import XCTest

class ComicsStorageSourceTests: ComicsSourceTests {
    
    private var storageSource = ComicsStorageSource()
    override var comicsSource: ComicsSource! {
        get {
            storageSource
        }
        set {
            if let storageSource = newValue as? ComicsStorageSource {
                self.storageSource = storageSource
            }
        }
    }
    
    override func setUp() {
        super.setUp()
        
        for number in 1...5 {
            let comic = Comic(title: "",
                              description: "",
                              imageData: .init(),
                              number: number,
                              publicationDate: nil,
                              explainationUrlString: "",
                              isFavourite: false)
            
            StorageManager.shared.saveComic(comic)
        }
        
        storageSource.updateComics()
    }
    
}
