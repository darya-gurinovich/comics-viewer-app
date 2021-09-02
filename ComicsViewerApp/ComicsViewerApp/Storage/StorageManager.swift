//
//  StorageManager.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 2.09.21.
//

import Foundation

struct StorageManager {
    private let realmStorage = RealmStorage()
    
    static let shared = StorageManager()
    
    private init() { }
    
    func getComic(number: Int) -> Comic? {
        realmStorage.getObject(primaryKey: number)
    }
    
    func saveComic(_ comic: Comic) {
        realmStorage.save(object: comic)
    }
    
    func deleteComic(_ comic: Comic) {
        realmStorage.delete(ofType: Comic.self,
                            primaryKey: comic.number)
    }
}
