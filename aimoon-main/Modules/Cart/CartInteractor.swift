//
//  CartInteractor.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

final class CartInteractor: CartInteractorInputProtocol {
    
    weak var presenter: CartInteractorOutputProtocol?
    
    var cartListManager: CartListManagerInputProtocol?
    
    // MARK: - Public Functions
    
    func getCartProducts() {
        let cartProducts = cartListManager?.getProducts() ?? []
        presenter?.cartProductsDidReceive(cartProducts)
    }
    
    func removeProductFromCart(_ product: Product) {
        cartListManager?.removeProductFromCart(product)
    }
    
    func setupObserver() {
        cartListManager?.activateNotification()
    }
    
}

// MARK: - Cart List Manager Output Protocol

extension CartInteractor: CartListManagerOutputProtocol {
    
    func cartListDidUpdate() {
        getCartProducts()
    }
    
}
