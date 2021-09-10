//
//  Events.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 31.01.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

final class Events {
    
    static let shared = Events()
    
    private var pointers: [WeakPointer<AnyObject>] = []
    
    private init() { }
    
    func addTarget(_ target: Eventable) {
        guard !pointers.contains(where: { $0.object === target }) else {
            return
        }
        
        let pointer = WeakPointer(target as AnyObject)
        pointers.append(pointer)
    }
    
    func report(_ message: Message) {
        var index = 0
        
        while index < pointers.count {
            guard let target = pointers[index].object as? Eventable else {
                pointers.remove(at: index)
                continue
            }
            
            target.handleEvent(message)
            index += 1
        }
    }
    
    // MARK: - Messagess
    
    enum Message {
        
        case bannerDidPress(_ section: TabBarSection)
        case signInButtonDidPress
        
        case toCategoryButtonDidPress
        case toCartButtonDidPress
        
        case successOrderingButtonDidPress(isAuth: Bool)
        
        case userDidAuth
        case userDidLogout
        
        case remoteProductsDidSync
        case profileViewDidAppear
        
    }
    
}

// MARK: - Eventable

protocol Eventable: AnyObject {
    
    func handleEvent(_ message: Events.Message)
    
}
