//
//  File.swift
//  
//
//  Created by Dasha Gurinovich on 1.09.21.
//

import Foundation

enum XkcdComicError: Error, Equatable {
    case dataLoadingFailed
    case imageLoadingFailed
    
    case currentComicMissing
    case totalComicsNumberUnknown
    case noPreviousComic
    case noNextComic
    
}

extension XkcdComicError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .dataLoadingFailed:
            return "Couldn't load the comic"
            
        case .imageLoadingFailed:
            return "Couldn't load the comic image"
            
        case .currentComicMissing:
            return "Couldn't load a comic"
            
        case .totalComicsNumberUnknown:
            return "Couldn't load total comics number"
            
        case .noPreviousComic:
            return "The previous comic is missing"
            
        case .noNextComic:
            return "The next comic is missing"
            
        }
    }
}
