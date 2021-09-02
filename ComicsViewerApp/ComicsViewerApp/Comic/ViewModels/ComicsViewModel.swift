//
//  ComicViewModel.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 2.09.21.
//

import Foundation
import XkcdComicsKit

class ComicsViewModel: ObservableObject {
    @Published var comic: Comic? {
        didSet {
            guard let comic = comic else { return }
            
            if comic.isFavourite {
                StorageManager.shared.saveComic(comic)
            }
            else {
                StorageManager.shared.deleteComic(comic)
            }
        }
    }
    
    @Published var error: Error?
    
    func fetchCurrentComic() {
        XkcdComicsKit.default.fetchCurrentComic(completion: updateData)
    }
    
    func fetchFirstComic() {
        XkcdComicsKit.default.fetchFirstComic(completion: updateData)
    }
    
    func fetchPreviousComic() {
        XkcdComicsKit.default.fetchPreviousComic(completion: updateData)
    }
    
    func fetchNextComic() {
        XkcdComicsKit.default.fetchNextComic(completion: updateData)
    }
    
    func fetchLatestComic() {
        XkcdComicsKit.default.fetchLatestComic(completion: updateData)
    }
    
    private func updateData(comicData: XkcdComic?, error: Error?) {
        if let comicData = comicData {
            let isFavourite = StorageManager.shared.getComic(number: comicData.number)?.isFavourite ?? false
            
            let comic = Comic(title: comicData.title,
                                   description: comicData.description,
                                   imageData: comicData.imageData,
                                   number: comicData.number,
                                   publicationDate: comicData.publicationDate,
                                   explainationUrlString: comicData.explainationUrlString,
                                   isFavourite: isFavourite)
            
            self.comic = comic
        }
        
        self.error = error
    }
}
