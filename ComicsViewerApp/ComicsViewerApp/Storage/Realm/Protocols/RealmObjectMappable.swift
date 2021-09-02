//
//  RealmObjectMappable.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 2.09.21.
//

import RealmSwift

/// Protocol to automatically map object to its `RealmObject`
protocol RealmObjectMappable {
    static var realmObjectType: Object.Type { get }
    
    func getRealmObject() -> Object
    
    static func createInstance(from realmObject: Object?) -> RealmObjectMappable?
}
