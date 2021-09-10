//
//  DBManager.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 15.11.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import RealmSwift

protocol DBManager: AnyObject {
    
    associatedtype Element: Object
    
    var storage: Storage { get }
    
    func getObject(id: Int) -> Element?
    
    func getObjects() -> Results<Element>?
    
    func write(object: Element)
    
    func write(objects: Results<Element>)
    
    func write(objects: [Element])
    
    func remove(object: Element)
    
    func remove(objects: Results<Element>)
    
}

extension DBManager {
    
    func getObject(id: Int) -> Element? {
        return storage.db?.object(ofType: Element.self, forPrimaryKey: id)
    }
    
    func write(_ updates: () -> Void) {
        try? storage.db?.write {
            updates()
        }
    }
    
    func write(object: Element) {
        write {
            storage.db?.add(object, update: .modified)
        }
    }
    
    func write(objects: Results<Element>) {
        write {
            storage.db?.add(objects, update: .modified)
        }
    }
    
    func write(objects: [Element]) {
        write {
            storage.db?.add(objects, update: .modified)
        }
    }
    
    func remove(object: Element) {
        write {
            storage.db?.delete(object)
        }
    }
    
    func remove(objects: Results<Element>) {
        write {
            storage.db?.delete(objects)
        }
    }
    
    func getObjects() -> Results<Element>? {
        return storage.db?.objects(Element.self)
    }
    
}
