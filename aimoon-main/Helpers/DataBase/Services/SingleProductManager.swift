//
//  SingleProductManager.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 08.02.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import RealmSwift

protocol SingleProductManagerInputProtocol: AnyObject {
    
    var output: SingleProductManagerOutputProtocol? { get set }
    
    var productManager: ProductManager { get }
    
    var sender: FavoriteProductSender { get }
    
    var dbProduct: DBProduct? { get }
    
    var notificationToken: NotificationToken? { get }
    
    func setAsFavorite(product: Product, needSendToServer: Bool)
    
    func setAsNotFavorite(product: Product, needDeleteFromServer: Bool)
    
    func setAsViewed(product: Product)
    
    func addToCart(product: Product)
    
    func activateNotification()
    
}

protocol SingleProductManagerOutputProtocol: AnyObject {
    
    func productFavoriteStateDidChange(_ isFavorite: Bool)
    
    func productCartStateDidChange(_ isAddedToCart: Bool)
    
}

final class SingleProductManager: SingleProductManagerInputProtocol {
    
    weak var output: SingleProductManagerOutputProtocol?
    private(set)var notificationToken: NotificationToken?
    
    private(set) var productManager: ProductManager
    private(set) var sender: FavoriteProductSender
    
    private(set)var dbProduct: DBProduct?
    
    init(productID: Int) {
        productManager = ProductManager()
        sender = FavoriteProductSender()
        
        dbProduct = productManager.getObject(id: productID)
    }
    
    func setAsViewed(product: Product) {
        productManager.setViewedState(product: product)
        
        if dbProduct == nil {
            dbProduct = productManager.getObject(id: product.id)
            activateNotification()
        }
    }
    
    func setAsFavorite(product: Product, needSendToServer: Bool) {
        if needSendToServer {
            sender.addToServer(product) { [weak self] result in
                switch result {
                    case .success:
                        self?.productManager.setFavoriteState(true, product: product)
                    case .fail:
                        self?.output?.productFavoriteStateDidChange(false)
                }
            }
        } else {
            productManager.setFavoriteState(true, product: product)
        }
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
                                self?.output?.productFavoriteStateDidChange(true)
                        }
                }
            }
        } else {
            productManager.setFavoriteState(false, product: product)
        }
    }
    
    func addToCart(product: Product) {
        productManager.setCartState(true, product: product)
    }
    
    func activateNotification() {
        notificationToken = dbProduct?.observe { [weak self] change in
            switch change {
                case .change(_, let properties):
                    guard let property = properties.first else {
                        return
                    }
                    
                    switch property.name {
                        case "isFavorite":
                            guard let boolValue = (property.newValue as? Int)?.bool else {
                                return
                            }
                            
                            self?.output?.productFavoriteStateDidChange(boolValue)
                        case "isAddedToCart":
                            guard let boolValue = (property.newValue as? Int)?.bool else {
                                return
                            }
                            
                            self?.output?.productCartStateDidChange(boolValue)
                        default:
                            break
                    }
                default:
                    break
            }
        }
    }
    
}
