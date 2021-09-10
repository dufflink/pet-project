//
//  Realm.Results.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 27.11.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import RealmSwift

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        return self.compactMap { $0 as? T }
    }
    
    func toProductsArray() -> [Product] {
        return self.toArray(ofType: DBProduct.self).compactMap { $0.toProduct }
    }
    
}
