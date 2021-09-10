//
//  SyncManagerFavoriteProducts.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 06.03.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

final class SyncManagerFavoriteProducts: ProductManager, SyncManagerProtocol {
    
    typealias Element = Product
    
    // MARK: - Public Functions
    
    func syncObjects(completion: @escaping (OperationResult) -> Void) {
        guard let dbFavoriteProducts = getFavoriteProducts() else {
            completion(.fail(.fetchingError))
            return
        }
        
        guard !dbFavoriteProducts.isEmpty else {
            completion(.success)
            return
        }
        
        let favoriteProducts = dbFavoriteProducts.toProductsArray()
        
        if favoriteProducts.count != dbFavoriteProducts.count {
            print("Кол-во избранных товаров по какой-то причине отличается")
            completion(.fail(.fetchingError))
            return
        }
        
        let ids = favoriteProducts.compactMap { $0.id }
        
        API.shared.mergeFavoriteProducts(ids: ids).then { _ in
            completion(.success)
        }.catch { apiError in
            completion(.fail(.serverError(apiError)))
        }
    }
    
    func getAndSaveSyncedObjects(completion: @escaping (API.Error?) -> Void = { _  in }) {
        API.shared.getFavoriteProducts().then { [weak self] result in
            let products = result.items
            
            if !products.isEmpty {
                self?.save(products: products)
            }
            
            completion(nil)
        }.catch { apiError in
            completion(apiError)
        }
    }
    
    func getSyncedObjects(completion: @escaping (Portion<Product>?, API.Error?) -> Void = { _, _  in }) {
        API.shared.getFavoriteProducts().then { result in
            completion(result, nil)
        }.catch { apiError in
            completion(nil, apiError)
        }
    }
    
}
