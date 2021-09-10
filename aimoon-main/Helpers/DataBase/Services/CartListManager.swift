//
//  CartListManager.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 04.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import RealmSwift

protocol CartListManagerInputProtocol: AnyObject {
    
    var output: CartListManagerOutputProtocol? { get set }
        
    var dbProducts: Results<DBProduct>? { get }
    
    var notificationToken: NotificationToken? { get }
    
    var productManager: ProductManager { get }
    
    func activateNotification()
    
    func getProducts() -> [Product]
    
    // MARK: - Additional Functions
    
    func removeProductFromCart(_ product: Product)
    
}

protocol CartListManagerOutputProtocol: AnyObject {
    
    func cartListDidUpdate()
    
}

final class CartListManager: CartListManagerInputProtocol {
    
    weak var output: CartListManagerOutputProtocol?
    
    private(set) var notificationToken: NotificationToken?
    private(set) var dbProducts: Results<DBProduct>?
    
    private(set) var productManager: ProductManager
    
    // MARK: - Life Cycle
    
    init() {
        productManager = ProductManager()
        dbProducts = productManager.getCartProducts()
    }
    
    // MARK: - Viewed List Protocol
    
    func activateNotification() {
        notificationToken = dbProducts?.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
                case .initial:
                    print("Cart List did initialize")
                case .update:
                    self?.output?.cartListDidUpdate()
                case .error(let error):
                    print(error)
            }
        }
    }
    
    func getProducts() -> [Product] {
        return dbProducts?.toProductsArray() ?? []
    }
    
    func removeProductFromCart(_ product: Product) {
        productManager.setCartState(false, product: product)
    }
    
}
