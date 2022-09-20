//
//  Comic.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 2.09.21.
//

import Foundation

struct Comic {
    let title: String
    let description: String
    
    let imageData: Data
    let number: Int
    
    let publicationDate: Date?
    let explainationUrlString: String
    
    var isFavourite: Bool
}
