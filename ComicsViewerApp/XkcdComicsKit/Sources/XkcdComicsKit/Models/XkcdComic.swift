//
//  File.swift
//  
//
//  Created by Dasha Gurinovich on 1.09.21.
//

import Foundation

public struct XkcdComic {
    public let title: String
    public let description: String
    
    public let imageData: Data
    public let number: Int
    
    public let publicationDate: Date?
    public let explainationUrlString: String
}

struct XkcdComicData: Decodable {
    let title: String
    let description: String
    
    let imageUrl: String
    let number: Int
    
    let day: String
    let month: String
    let year: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "alt"
        
        case imageUrl = "img"
        case number = "num"
        
        case day
        case month
        case year
    }
}
