//
//  ComicSource.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 2.09.21.
//

import Foundation

protocol ComicsSource {
    var totalComicsNumber: Int? { get }
    
    mutating func fetchCurrentComic(completion: @escaping (Comic?, Error?) -> Void)
     
    mutating func fetchFirstComic(completion: @escaping (Comic?, Error?) -> Void)
    mutating func fetchPreviousComic(completion: @escaping (Comic?, Error?) -> Void)
    
    mutating func fetchNextComic(completion: @escaping (Comic?, Error?) -> Void)
    mutating func fetchLatestComic(completion: @escaping (Comic?, Error?) -> Void)
    
    mutating func updateComics()
}
