//
//  ComicStorageSource.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 2.09.21.
//

import Foundation

struct ComicsStorageSource: ComicsSource {
    private var comics: [Comic]
    
    var totalComicsNumber: Int? { comicsNumber }
    
    private var comicsNumber: Int { comics.count }
    private var currentComicNumber: Int?
    
    init() {
        self.comics = StorageManager.shared.getAllComics()
        self.currentComicNumber = comics.endIndex - 1
    }
    
    mutating func updateComics() {
        self.comics = StorageManager.shared.getAllComics()
    }
    
    mutating func fetchCurrentComic(completion: @escaping (Comic?, Error?) -> Void) {
        let currentComicNumber = self.currentComicNumber ?? comics.endIndex - 1
        
        fetchComic(index: currentComicNumber, completion: completion)
    }
    
    mutating func fetchFirstComic(completion: @escaping (Comic?, Error?) -> Void) {
        fetchComic(index: 0, completion: completion)
    }
    
    mutating func fetchPreviousComic(completion: @escaping (Comic?, Error?) -> Void) {
        let currentComicNumber = self.currentComicNumber ?? comics.endIndex - 1
        
        fetchComic(index: currentComicNumber - 1, completion: completion)
    }
    
    mutating func fetchNextComic(completion: @escaping (Comic?, Error?) -> Void) {
        let currentComicNumber = self.currentComicNumber ?? comics.endIndex - 1
        
        fetchComic(index: currentComicNumber + 1, completion: completion)
    }
    
    mutating func fetchLatestComic(completion: @escaping (Comic?, Error?) -> Void) {
        fetchComic(index: comicsNumber - 1, completion: completion)
    }
    
    private mutating func fetchComic(index: Int, completion: @escaping (Comic?, Error?) -> Void) {
        guard index >= 0 && index < comicsNumber else {
            completion(nil, SourceError.incorrectIndex)
            
            return
        }
        
        currentComicNumber = index
        completion(comics[index], nil)
    }
    
    enum SourceError: Error {
        case incorrectIndex
        case currentComicMissing
    }
}

extension ComicsStorageSource.SourceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .incorrectIndex:
            return "You've reached the end"
            
        case .currentComicMissing:
            return "Couldn't load a comic"
            
        }
    }
}
