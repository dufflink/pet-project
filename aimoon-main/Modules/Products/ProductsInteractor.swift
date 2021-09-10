//
//  ProductsInteractor.swift
//  aimoon-main
//

import UIKit

final class ProductsInteractor: ProductsInteractorInputProtocol {
    
    weak var presenter: ProductsInteractorOutputProtocol?
    
    var category: Category
    var favoriteListManager: FavoriteListManagerInputProtocol?
    
    init(category: Category, favoriteListManager: FavoriteListManagerInputProtocol) {
        self.category = category
        self.favoriteListManager = favoriteListManager
    }
    
    func setupObserver() {
        favoriteListManager?.activateNotification()
    }
    
    func setAsFavorite(product: Product) {
        favoriteListManager?.setAsFavorite(product: product, needSendToServer: false)
    }
    
    func setAsNotFavorite(product: Product) {
        favoriteListManager?.setAsNotFavorite(product: product, needDeleteFromServer: false)
    }
    
    func getFavoriteProducts() {
        if let favotireProducts = favoriteListManager?.dbProducts?.toProductsArray() {
            presenter?.favoriteProductsDidReceive(favotireProducts)
        }
    }
    
    func getProducts(page: Int? = nil) {
        API.shared.getProducts(categoryID: category.id, page: page).then { [weak self] result in
            guard let metaData = result.metaData else {
                let error = API.Error(code: .unknown, message: "Meta data не найдена", statusCode: .notFound)
                self?.presenter?.productReceivingDidFail(error)
                return
            }
            
            let hasMorePage = metaData.currentPage < metaData.pageCount
            self?.presenter?.productsDidReceive(result.items, hasMorePage: hasMorePage)
        }.catch { [weak self] error in
            self?.presenter?.productReceivingDidFail(error)
        }
    }
    
    func setSorting() {
        // Set new sort for products
    }
    
    func setFilters() {
        // Set new filter for products
    }

}

// MARK: - Favorite List Controller Output Protocol

extension ProductsInteractor: FavoriteListManagerOutputProtocol {
    
    func productDidSetAsFavorite(_ product: Product) {
        presenter?.productDidSetAsFavorite(product)
    }
    
    func productDidRemoveFromFavorite(at index: Int) {
        presenter?.productDidRemoveFromFavorite(at: index)
    }
    
}
