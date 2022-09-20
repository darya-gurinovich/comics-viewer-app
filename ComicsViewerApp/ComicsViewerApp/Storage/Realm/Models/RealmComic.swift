//
//  RealmComic.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 2.09.21.
//

import Foundation
import RealmSwift

class RealmComic: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var comicDescription: String = ""
    
    @objc dynamic var imageData: Data = .init()
    @objc dynamic var number: Int = 0
    
    @objc dynamic var publicationDate: Date?
    @objc dynamic var explainationUrlString: String = ""
    
    @objc dynamic var isFavourite: Bool = false
    
    override static func primaryKey() -> String? {
        return "number"
    }
    
    convenience init(title: String,
         comicDescription: String,
         imageData: Data,
         number: Int,
         publicationDate: Date?,
         explainationUrlString: String,
         isFavourite: Bool) {
        self.init()
        
        self.title = title
        self.comicDescription = comicDescription
        
        self.imageData = imageData
        self.number = number
        
        self.publicationDate = publicationDate
        self.explainationUrlString = explainationUrlString
        
        self.isFavourite = isFavourite
    }
}

extension Comic: RealmObjectMappable {
    static var realmObjectType: Object.Type { RealmComic.self }
    
    func getRealmObject() -> Object {
        RealmComic(title: title,
                   comicDescription: description,
                   imageData: imageData,
                   number: number,
                   publicationDate: publicationDate,
                   explainationUrlString: explainationUrlString,
                   isFavourite: isFavourite)
    }
    
    static func createInstance(from realmObject: Object?) -> RealmObjectMappable? {
        guard let realmComic = realmObject as? RealmComic else { return nil }
        
        return Comic(title: realmComic.title,
                     description: realmComic.comicDescription,
                     imageData: realmComic.imageData,
                     number: realmComic.number,
                     publicationDate: realmComic.publicationDate,
                     explainationUrlString: realmComic.explainationUrlString,
                     isFavourite: realmComic.isFavourite)
    }
}
