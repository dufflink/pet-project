//
//  WeakPointer.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 31.01.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

final class WeakPointer<T: AnyObject> {
    
    private(set) weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
    
}
