//
//  ComicViewModel.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 2.09.21.
//

import Foundation
import XkcdComicsKit

class ComicsViewModel: ObservableObject {
    private var comicsSource: ComicsSource
    
    let navigationBarTitle: String
    let showsNavigationBarButtons: Bool
    
    var comicsNumber: Int? { comicsSource.totalComicsNumber }
    
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
    
    @Published var isLoading: Bool = false
    
    init(comicsSource: ComicsSource,
         navigationBarTitle: String = "",
         showsNavigationBarButtons: Bool = true) {
        self.comicsSource = comicsSource
        
        self.navigationBarTitle = navigationBarTitle
        self.showsNavigationBarButtons = showsNavigationBarButtons
    }
    
    func refreshData() {
        comicsSource.updateComics()
        
        // If there's no comics after the refresh, remove the current comic
        if comicsNumber == 0 {
            self.comic = nil
        }
    }
    
    func fetchCurrentComic() {
        // If there's no comics, don't fetch a new comic
        guard comicsNumber != 0 else { return }
        
        isLoading = true
        
        comicsSource.fetchCurrentComic(completion: updateData)
    }
    
    func fetchFirstComic() {
        isLoading = true
        
        comicsSource.fetchFirstComic(completion: updateData)
    }
    
    func fetchPreviousComic() {
        isLoading = true
        
        comicsSource.fetchPreviousComic(completion: updateData)
    }
    
    func fetchNextComic() {
        isLoading = true
        
        comicsSource.fetchNextComic(completion: updateData)
    }
    
    func fetchLatestComic() {
        isLoading = true
        
        comicsSource.fetchLatestComic(completion: updateData)
    }
    
    private func updateData(comic: Comic?, error: Error?) {
        if let comic = comic {
            self.comic = comic
        }
        
        self.error = error
        self.isLoading = false
    }
}
