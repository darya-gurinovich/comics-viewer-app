//
//  RealmStorage.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 2.09.21.
//

import Foundation
import RealmSwift

struct RealmStorage {
    func getObject<T: RealmObjectMappable>(primaryKey: Any) -> T? {
        guard let realm = try? Realm() else { return nil }
        
        let realmType = T.realmObjectType
        guard let object = realm.object(ofType: realmType, forPrimaryKey: primaryKey) else { return nil }
        
        let mappable = T.createInstance(from: object)
        
        return mappable as? T
    }
    
    func save<T: RealmObjectMappable>(object: T) {
        guard let realm = try? Realm() else { return }
        
        let realmObject = object.getRealmObject()
        
        try? realm.write() {
            realm.add(realmObject, update: .modified)
        }
    }
    
    func delete<T: RealmObjectMappable>(ofType type: T.Type,
                                        primaryKey: Any) {
        guard let realm = try? Realm() else { return }
        
        let realmType = type.realmObjectType
        guard let realmObject = realm.object(ofType: realmType, forPrimaryKey: primaryKey) else { return }
        
        try? realm.write() {
            realm.delete(realmObject)
        }
    }
}
