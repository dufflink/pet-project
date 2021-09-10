//
//  ProductDetailInteractor.swift
//  aimoon-main
//

import UIKit

final class ProductDetailInteractor: ProductDetailInteractorInputProtocol {
    
    weak var presenter: ProductDetailInteractorOutputProtocol?
    
    var localStorage = LocaleStorage()
    var singleProductManager: SingleProductManagerInputProtocol?
    
    var product: Product?
    var productID: Int
    
    // MARK: - Life Cycle
    
    init(productID: Int) {
        self.productID = productID
    }
    
    // MARK: - Public Functions
    
    func getProduct() {
        API.shared.getProduct(id: productID).then { [weak self] serverProduct in
            guard var dbProduct = self?.singleProductManager?.dbProduct?.toProduct else {
                self?.product = serverProduct
                self?.presenter?.productDidReceive(serverProduct)
                return
            }
            
            if self?.localStorage.isUserAuth == true {
                dbProduct.isFavorite = serverProduct.isFavorite
            }
            
            self?.product = dbProduct
            self?.presenter?.productDidReceive(dbProduct)
        }.catch { [weak self] error in
            self?.presenter?.productReceivingDidFail(error)
        }
    }
    
    func getImageData(index: Int) {
        if let image = product?.images[safe: index], let url = URL(string: image.url), let data = try? Data(contentsOf: url), let uiImage = UIImage(data: data) {
            presenter?.imageDataDidReceive(image: uiImage)
        } else {
            presenter?.imageDataReceivingDidFail()
        }
    }
    
    func addProductToCart() {
        guard let product = product else {
            return
        }
        
        singleProductManager?.addToCart(product: product)
    }
    
    func setAsViewed() {
        guard let product = product else {
            return
        }
        
        singleProductManager?.setAsViewed(product: product)
    }
    
    func setAsFavorite() {
        guard let product = product else {
            return
        }
        
        singleProductManager?.setAsFavorite(product: product, needSendToServer: localStorage.isUserAuth)
    }
    
    func setAsNotFavorite() {
        guard let product = product else {
            return
        }
        
        singleProductManager?.setAsNotFavorite(product: product, needDeleteFromServer: localStorage.isUserAuth)
    }
    
    func setupObserver() {
        singleProductManager?.activateNotification()
    }

}

// MARK: - Favorite Product Manager Output Protocol

extension ProductDetailInteractor: SingleProductManagerOutputProtocol {
    
    func productFavoriteStateDidChange(_ isFavorite: Bool) {
        presenter?.productFavoriteStateDidChange(isFavorite)
    }
    
    func productCartStateDidChange(_ isAddedToCart: Bool) {
        presenter?.productCartStateDidChange(isAddedToCart)
    }
    
}
