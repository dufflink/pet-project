//
//  SyncManager.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 06.03.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

protocol SyncManagerProtocol: AnyObject {
    
    associatedtype Element: Codable, Equatable
    
    func syncObjects(completion: @escaping (OperationResult) -> Void)
    
    func getSyncedObjects(completion: @escaping (Portion<Element>?, API.Error?) -> Void)
    
    func getAndSaveSyncedObjects(completion: @escaping (API.Error?) -> Void)
    
}
