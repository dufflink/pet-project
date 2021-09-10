//
//  FavoriteListController.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 25.11.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import RealmSwift

protocol FavoriteListManagerInputProtocol: AnyObject {
    
    var output: FavoriteListManagerOutputProtocol? { get set }
        
    var dbProducts: Results<DBProduct>? { get }
    
    var notificationToken: NotificationToken? { get }
    
    var productManager: ProductManager { get }
    
    var sender: FavoriteProductSender { get }
    
    func setAsFavorite(product: Product, needSendToServer: Bool)
    
    func setAsNotFavorite(product: Product, needDeleteFromServer: Bool)
    
    func activateNotification()
    
    func removeNotification()
    
}

protocol FavoriteListManagerOutputProtocol: AnyObject {
    
    func productDidSetAsFavorite(_ product: Product)
    
    func productDidRemoveFromFavorite(at index: Int)
    
}

final class FavoriteListManager: FavoriteListManagerInputProtocol {
    
    weak var output: FavoriteListManagerOutputProtocol?
    
    private(set) var notificationToken: NotificationToken?
    private(set) var dbProducts: Results<DBProduct>?
    
    private(set) var productManager: ProductManager
    private(set) var sender: FavoriteProductSender
    
    // MARK: - Life Cycle
    
    init() {
        productManager = ProductManager()
        sender = FavoriteProductSender()
        
        dbProducts = productManager.getFavoriteProducts()
    }
    
    // MARK: - Favorite List Manager Protocol
    
    func setAsFavorite(product: Product, needSendToServer: Bool) {
        if product.id == sender.sendingObject?.id && sender.isSending {
            sender.currentRequest?.cancel()
            return
        }
        
        productManager.setFavoriteState(true, product: product)
    }
    
    func setAsNotFavorite(product: Product, needDeleteFromServer: Bool) {
        if needDeleteFromServer {
            sender.deleteFromServer(product) { [weak self] result in
                switch result {
                    case .success:
                        self?.productManager.setFavoriteState(false, product: product)
                    case .fail(let error):
                        switch error {
                            case .serverError(let apiError) where apiError.statusCode == .notFound:
                                self?.productManager.setFavoriteState(false, product: product)
                            default:
                                self?.output?.productDidSetAsFavorite(product)
                        }
                }
            }
        } else {
            productManager.setFavoriteState(false, product: product)
        }
    }
    
    func activateNotification() {
        notificationToken = dbProducts?.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
                case .initial:
                    print("FavoriteListManager did initialize")
                case .update(_, let deletions, let insertions, _):
                    if !insertions.isEmpty {
                        self?.handleInsertion(rows: insertions)
                    }
                    
                    if !deletions.isEmpty {
                        self?.handleDeleting(rows: deletions)
                    }
                case .error(let error):
                    print(error)
            }
        }
    }
    
    func removeNotification() {
        notificationToken = nil
    }
    
    // MARK: - Private Functions
    
    private func handleInsertion(rows: [Int]) {
        for row in rows {
            guard let dbProduct = dbProducts?[row] else {
                print("Couldn't handle insert")
                return
            }
            
            output?.productDidSetAsFavorite(dbProduct.toProduct)
        }
    }
    
    private func handleDeleting(rows: [Int]) {
        guard let row = rows.first else {
            print("Couldn't handle delete")
            return
        }
        
        output?.productDidRemoveFromFavorite(at: row)
    }
    
}
