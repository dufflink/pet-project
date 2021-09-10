//
//  Promise.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 03.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import Moya

class Promise<T: Decodable> {
    
    fileprivate let serverMethod: API.Method
    fileprivate var executingRequest: Cancellable?
    
    // MARK: - Life Cycle
    
    init(_ serverMethod: API.Method) {
        self.serverMethod = serverMethod
        restart()
    }
    
    // MARK: - Final Actions
    
    private var checkAction: (T) -> Bool = { _ in true }
    
    func check(_ action: @escaping (T) -> Bool) -> Promise<T> {
        checkAction = action
        return self
    }
    
    private var thenAction: (T) -> Void = { _ in }
    
    @discardableResult func then(_ action: @escaping (T) -> Void) -> Promise<T> {
        thenAction = action
        return self
    }
    
    private var catchAction: (API.Error) -> Void = { _ in }
    
    @discardableResult func `catch`(_ action: @escaping (API.Error) -> Void) -> Promise<T> {
        catchAction = action
        return self
    }
    
    private var anywayAction: () -> Void = { }
    
    func anyway(_ action: @escaping () -> Void) {
        anywayAction = action
    }
    
    // MARK: - Public Properties
    
    fileprivate(set) var isRunning = false
    
    // MARK: - Public Functions
    
    func restart() {
        cancel()
        
        isRunning = true
        executingRequest = API.shared.request(serverMethod, with: self)
    }
    
    func finish(_ response: T) {
        isRunning = false
        anywayAction()
        
        guard checkAction(response) else {
            let error = API.Error(code: .unknown, statusCode: .unknown)
            catchAction(error)
            
            return
        }
        
        thenAction(response)
    }
    
    func finish(_ error: API.Error) {
        isRunning = false
        anywayAction()
        
        catchAction(error)
    }
    
    func cancel() {
        executingRequest?.cancel()
        isRunning = false
    }
    
}
