//
//  ComicXkcdSource.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 2.09.21.
//

import Foundation
import XkcdComicsKit

struct ComicsXkcdSource: ComicsSource {
    var totalComicsNumber: Int? { XkcdComicsKit.default.totalComicsNumber }
    
    func updateComics() { }
    
    func fetchCurrentComic(completion: @escaping (Comic?, Error?) -> Void) {
        XkcdComicsKit.default.fetchCurrentComic {
            updateData(comicData: $0, error: $1, completion: completion)
        }
    }
    
    func fetchFirstComic(completion: @escaping (Comic?, Error?) -> Void) {
        XkcdComicsKit.default.fetchFirstComic {
            updateData(comicData: $0, error: $1, completion: completion)
        }
    }
    
    func fetchPreviousComic(completion: @escaping (Comic?, Error?) -> Void) {
        XkcdComicsKit.default.fetchPreviousComic {
            updateData(comicData: $0, error: $1, completion: completion)
        }
    }
    
    func fetchNextComic(completion: @escaping (Comic?, Error?) -> Void) {
        XkcdComicsKit.default.fetchNextComic {
            updateData(comicData: $0, error: $1, completion: completion)
        }
    }
    
    func fetchLatestComic(completion: @escaping (Comic?, Error?) -> Void) {
        XkcdComicsKit.default.fetchLatestComic {
            updateData(comicData: $0, error: $1, completion: completion)
        }
    }
    
    private func updateData(comicData: XkcdComic?,
                            error: Error?,
                            completion: @escaping (Comic?, Error?) -> Void) {
        if let comicData = comicData {
            // Get isFavourite status from the database
            let isFavourite = StorageManager.shared.getComic(number: comicData.number)?.isFavourite ?? false
            
            let comic = Comic(title: comicData.title,
                              description: comicData.description,
                              imageData: comicData.imageData,
                              number: comicData.number,
                              publicationDate: comicData.publicationDate,
                              explainationUrlString: comicData.explainationUrlString,
                              isFavourite: isFavourite)
            
            completion(comic, nil)
            
            return
        }
        
        completion(nil, error)
    }
}
