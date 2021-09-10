//
//  ViewedListManager.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 28.03.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import RealmSwift

protocol ViewedListManagerInputProtocol: AnyObject {
    
    var output: ViewedListManagerOutputProtocol? { get set }
        
    var dbProducts: Results<DBProduct>? { get }
    
    var notificationToken: NotificationToken? { get }
    
    var productManager: ProductManager { get }
    
    func activateNotification()
    
    func getViewedProducts(limit: Int?) -> [Product]
    
}

protocol ViewedListManagerOutputProtocol: AnyObject {
    
    func viewedProductsDidUpdate()
    
}

final class ViewedListManager: ViewedListManagerInputProtocol {
    
    weak var output: ViewedListManagerOutputProtocol?
    
    private(set) var notificationToken: NotificationToken?
    private(set) var dbProducts: Results<DBProduct>?
    
    private(set) var productManager: ProductManager
    
    // MARK: - Life Cycle
    
    init() {
        productManager = ProductManager()
        dbProducts = productManager.getViewedProducts()
    }
    
    // MARK: - Viewed List Protocol
    
    func activateNotification() {
        notificationToken = dbProducts?.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
                case .initial:
                    print("Viewed List did initialize")
                case .update:
                    self?.output?.viewedProductsDidUpdate()
                case .error(let error):
                    print(error)
            }
        }
    }
    
    func getViewedProducts(limit: Int? = nil) -> [Product] {
        var products = dbProducts?.toProductsArray() ?? []
        
        if let limit = limit, !products.isEmpty, products.count > limit {
            products = Array(products[0 ... limit - 1])
        }
        
        return products
    }
    
}
