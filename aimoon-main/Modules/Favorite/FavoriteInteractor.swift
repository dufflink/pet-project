//
//  FavoriteInteractor.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

final class FavoriteInteractor: FavoriteInteractorInputProtocol {
    
    weak var presenter: FavoriteInteractorOutputProtocol?
    var localStorage = LocaleStorage()
    
    var favoriteListManager: FavoriteListManagerInputProtocol?
    var productManager: SyncManagerFavoriteProducts?
    
    init(favoriteListManager: FavoriteListManagerInputProtocol) {
        self.favoriteListManager = favoriteListManager
    }
    
    func getLocalFavoriteProducts() {
        if let products = favoriteListManager?.dbProducts?.toProductsArray() {
            presenter?.favoriteProductsDidReceive(products, hasMorePage: false)
        }
    }
    
    func getRemoteFavoriteProducts() {
        productManager?.getSyncedObjects { [weak self] portion, error in
            if let error = error {
                self?.presenter?.gettingRemoteFavoriteProductsDidFail(error)
            }
            
            guard let products = portion?.items else {
                self?.presenter?.gettingRemoteFavoriteProductsDidFail(nil)
                return
            }
            
            self?.saveProducts(products)
            self?.presenter?.gettingRemoteFavoriteProductsDidFinish()
        }
    }
    
    func refreshFavoriteProducts() {
        productManager?.getSyncedObjects { [weak self] portion, error in
            if let error = error {
                self?.presenter?.refreshingFavoriteProductsDidFail(error)
            }
            
            guard let products = portion?.items else {
                self?.presenter?.refreshingFavoriteProductsDidFail(nil)
                return
            }
            
            self?.productManager?.clearFavoriteProductList()
            self?.saveProducts(products)
            
            self?.presenter?.refreshingFavoriteProductsDidFinish()
        }
    }

    func setAsFavorite(product: Product) {
        favoriteListManager?.setAsFavorite(product: product, needSendToServer: localStorage.isUserAuth)
    }
    
    func setAsNotFavorite(product: Product) {
        favoriteListManager?.setAsNotFavorite(product: product, needDeleteFromServer: localStorage.isUserAuth)
    }
    
    func setupObserver() {
        favoriteListManager?.activateNotification()
    }
    
    func removeObserver() {
        favoriteListManager?.removeNotification()
    }
    
    // MARK: - Private Functions
    
    private func saveProducts(_ products: [Product]) {
        var products = products
        
        if !products.isEmpty {
            guard let cartProducts = productManager?.getCartProducts()?.toProductsArray() else {
                return
            }
            
            // TODO: Удалить проверку в корзине, после того, как с сервера будет приходить isAddedToCart
            for cartProduct in cartProducts {
                if let index = products.firstIndex(where: { $0.id == cartProduct.id }) {
                    products[index].isAddedToCart = true
                }
            }
            
            productManager?.save(products: products)
        }
    }
    
}

// MARK: - Favorite List Controller Output Protocol

extension FavoriteInteractor: FavoriteListManagerOutputProtocol {
    
    func productDidSetAsFavorite(_ product: Product) {
        presenter?.productDidSetAsFavorite(product)
    }
    
    func productDidRemoveFromFavorite(at index: Int) {
        presenter?.productDidRemoveFromFavorite(at: index)
    }
    
}
