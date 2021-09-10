//
//  ProductManager.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 11.11.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import RealmSwift

class ProductManager: DBManager {
    
    typealias Element = DBProduct
    
    var storage: Storage
    
    // MARK: - Life Cycle
    
    init() {
        storage = Storage()
    }
    
    // MARK: - Public Functions
    
    func setViewedState(product: Product) {
        if let existProduct = getObject(id: product.id) {
            write {
                existProduct.setViewedState(true)
            }
        } else {
            let dbProduct = DBProduct(product: product)
            dbProduct.setViewedState(true)
            
            write(object: dbProduct)
        }
        
        updateViewedProductList()
    }
    
    func setFavoriteState(_ isFavorite: Bool, product: Product) {
        if let existProduct = getObject(id: product.id) {
            write {
                existProduct.setFavoriteState(isFavorite)
            }
        } else {
            let dbProduct = DBProduct(product: product)
            dbProduct.setFavoriteState(isFavorite)
            
            write(object: dbProduct)
        }
    }
    
    func setCartState(_ isAddedToCart: Bool, product: Product) {
        if let existProduct = getObject(id: product.id) {
            write {
                existProduct.setCartState(isAddedToCart)
            }
        } else {
            let dbProduct = DBProduct(product: product)
            dbProduct.setCartState(isAddedToCart)
            
            write(object: dbProduct)
        }
    }
    
    func getViewedProducts() -> Results<DBProduct>? {
        let predicate = NSPredicate(format: "isViewed == YES")
        return getObjects()?.filter(predicate).sorted(byKeyPath: "toViewedAdded", ascending: false)
    }
    
    func getFavoriteProducts() -> Results<DBProduct>? {
        let predicate = NSPredicate(format: "isFavorite == YES")
        return getObjects()?.filter(predicate).sorted(byKeyPath: "toFavoriteAdded", ascending: true)
    }
    
    func getCartProducts() -> Results<DBProduct>? {
        let predicate = NSPredicate(format: "isAddedToCart == YES")
        return getObjects()?.filter(predicate).sorted(byKeyPath: "toCartAdded", ascending: true)
    }
    
    func clearFavoriteProductList() {
        guard let products = getFavoriteProducts() else {
            return
        }
        
        for product in products {
            if product.isViewed || product.isAddedToCart {
                write {
                    product.setFavoriteState(false)
                }
            } else {
                remove(object: product)
            }
        }
    }
    
    func clearCartProductList() {
        guard let products = getCartProducts() else {
            return
        }
        
        for product in products {
            if product.isViewed || product.isFavorite {
                write {
                    product.setCartState(false)
                }
            } else {
                remove(object: product)
            }
        }
    }
    
    func save(products: [Product]) {
        let dbProducts = products.compactMap { DBProduct(product: $0) }
        write(objects: dbProducts)
    }
    
    func removeUnusedProducts() {
        // TODO: Нужно периодически очищать список неиспользуемых товаров
        
        let predicate = NSPredicate(format: "isAddedToCart == NO && isFavorite == NO && isViewed == NO")
        guard let objects = getObjects()?.filter(predicate).sorted(byKeyPath: "toFavoriteAdded", ascending: true) else {
            return
        }
        
        remove(objects: objects)
    }
    
    // MARK: - Private Functions
    
    private func updateViewedProductList() {
        guard let viewedProducts = getViewedProducts(), viewedProducts.count > 20, let lastViewedProduct = viewedProducts.last  else {
            return
        }
        
        if lastViewedProduct.isFavorite || lastViewedProduct.isAddedToCart {
            write {
                lastViewedProduct.setViewedState(false)
            }
        } else {
            remove(object: lastViewedProduct)
        }
    }
    
}
