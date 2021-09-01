//
//  File.swift
//  
//
//  Created by Dasha Gurinovich on 1.09.21.
//

import Foundation

enum XkcdComicError: Error {
    case dataLoadingFailed
    case imageLoadingFailed
    
    case currentComicMissing
    case totalComicsNumberUnknown
    case noPreviousComic
    case noNextComic
}
