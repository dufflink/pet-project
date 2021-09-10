//
//  SenderProtocol.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 14.03.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

protocol SenderProtocol: AnyObject {
    
    associatedtype Element: Codable
    
    var isSending: Bool { get }
    
    var currentRequest: Promise<Empty>? { get }
    
    var sendingObject: Element? { get }
    
    func addToServer(_ object: Element, completion: @escaping (OperationResult) -> Void)
    
    func deleteFromServer(_ object: Element, completion: @escaping (OperationResult) -> Void)
    
}
