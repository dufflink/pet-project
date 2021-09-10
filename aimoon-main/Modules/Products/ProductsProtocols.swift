//
//  ProductsProtocols.swift
//  aimoon-main
//

import UIKit

protocol ProductsRouterProtocol: BaseRouter {

    static func createModule(category: Category) -> AMViewController
    
    func openProductDetail(from view: BaseView?, product: Product)
    
    func openSortingModule(_ view: BaseView?)
    
    func openFilterModule(_ view: BaseView?)
    
}

protocol ProductsPresenterProtocol: ProductListPresenterProtocol {

    var interactor: ProductsInteractorInputProtocol? { get set }

    var router: ProductsRouterProtocol? { get set }

    init(router: ProductsRouterProtocol, view: ProductListViewProtocol, interactor: ProductsInteractorInputProtocol)

}

protocol ProductsInteractorInputProtocol: AnyObject {

    var presenter: ProductsInteractorOutputProtocol? { get set }
    
    var category: Category { get }
    
    var favoriteListManager: FavoriteListManagerInputProtocol? { get }
    
    init(category: Category, favoriteListManager: FavoriteListManagerInputProtocol)
    
    func getProducts(page: Int?)
    
    func getFavoriteProducts()
    
    func setAsFavorite(product: Product)
    
    func setAsNotFavorite(product: Product)
    
    func setupObserver()
    
    func setSorting()
    
    func setFilters()

}

protocol ProductsInteractorOutputProtocol: AnyObject {
    
    func productsDidReceive(_ products: [Product], hasMorePage: Bool)
    
    func favoriteProductsDidReceive(_ products: [Product])
    
    func productReceivingDidFail(_ error: API.Error)
    
    func productDidSetAsFavorite(_ product: Product)
    
    func productDidRemoveFromFavorite(at index: Int)
    
    func sortingDidSetup()
    
    func filtersDidSetup()
    
}
