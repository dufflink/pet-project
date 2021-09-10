//
//  FavoriteProductSender.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 14.03.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

final class FavoriteProductSender: SenderProtocol {
    
    typealias Element = Product
    
    var isSending = false
    var currentRequest: Promise<Empty>?
    
    var sendingObject: Product?
    
    // MARK: - Public Functions
    
    func addToServer(_ object: Product, completion: @escaping (OperationResult) -> Void) {
        guard !isSending else {
            completion(.fail(.operationInProgress))
            return
        }
        
        sendingObject = object
        
        let promise = API.shared.addFavoriteProduct(id: object.id)
        doOperation(with: promise, completion: completion)
    }
    
    func deleteFromServer(_ object: Product, completion: @escaping (OperationResult) -> Void) {
        guard !isSending else {
            completion(.fail(.operationInProgress))
            return
        }
        
        sendingObject = object
        
        let promise = API.shared.deleteFavoriteProduct(id: object.id)
        doOperation(with: promise, completion: completion)
    }
    
    // MARK: - Private Functions
    
    private func doOperation<T: Decodable>(with promise: Promise<T>, completion: @escaping (OperationResult) -> Void) {
        
        isSending = true
        currentRequest = promise as? Promise<Empty>

        currentRequest?.then { [weak self] _ in
            completion(.success)
            self?.isSending = false
        }.catch { [weak self] apiError in
            completion(.fail(.serverError(apiError)))
            self?.isSending = false
        }
    }
    
}
