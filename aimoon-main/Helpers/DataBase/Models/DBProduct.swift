//
//  DBProduct.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 11.11.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import RealmSwift

final class DBProduct: Object {
    
    // Обычные var всегда следует определять как dynamic
    
    @objc dynamic var id = 0
    @objc dynamic var quantity = 0
    
    @objc dynamic var name = ""
    @objc dynamic var price = 0
    
    @objc dynamic var isAddedToCart = false
    @objc dynamic var isFavorite = false
    @objc dynamic var isViewed = false
    
    @objc dynamic var toCartAdded: Date?
    @objc dynamic var toFavoriteAdded: Date?
    @objc dynamic var toViewedAdded: Date?
    
    // List, RealmOptional всегда следует определять как let и никогда как var dynamic
    
    let images = List<String>()
    let oldPrice = RealmOptional<Int>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: - Life Cycle
    
    convenience init(product: Product) {
        self.init()
        
        id = product.id
        quantity = product.quantity
        
        name = product.name
        price = product.price
        
        images.append(objectsIn: product.images.map { $0.url })
        oldPrice.value = product.oldPrice
        
        isFavorite = product.isFavorite ?? false
        isAddedToCart = product.isAddedToCart ?? false
    }
    
    // MARK: - Public Properties
    
    func setFavoriteState(_ isFavorite: Bool) {
        self.isFavorite = isFavorite
        toFavoriteAdded = isFavorite ? Date() : nil
    }
    
    func setViewedState(_ isViewed: Bool) {
        self.isViewed = isViewed
        toViewedAdded = isViewed ? Date() : nil
    }
    
    func setCartState(_ isAddedToCart: Bool) {
        self.isAddedToCart = isAddedToCart
        toCartAdded = isAddedToCart ? Date() : nil
    }
    
    var toProduct: Product {
        var imageObjects: [Image] = []
        
        for imageURL in images {
            imageObjects += [Image(url: imageURL)]
        }
        
        return Product(id: id, quantity: quantity, name: name, images: imageObjects, price: price, oldPrice: oldPrice.value, isFavorite: isFavorite, isAddedToCart: isAddedToCart)
    }
    
}
