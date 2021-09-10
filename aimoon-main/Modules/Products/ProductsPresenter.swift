//
//  ProductsPresenter.swift
//  aimoon-main
//

import UIKit

final class ProductsPresenter: ProductListPresenterProtocol {

    weak var view: ProductListViewProtocol?

    var interactor: ProductsInteractorInputProtocol?
    var router: ProductsRouterProtocol?
    
    var favoriteProducts: [Product] = []
    
    var products: [Product] = []
    var placeholderViewFactory: PlaceholderViewFactory

    var productsCount: Int {
        return products.count
    }
    
    var needShowFavoriteItem = false
    var isLoading = false
    
    var hasMorePage = false
    var nextPage = 1

    // MARK: - Life Cycle

    init(router: ProductsRouterProtocol, view: ProductListViewProtocol, interactor: ProductsInteractorInputProtocol) {
        self.router = router
        self.view = view

        self.interactor = interactor
        placeholderViewFactory = PlaceholderViewFactory()
    }

    func viewDidLoad() {
        let headerView = ProductListHeaderView(delegate: self)
        
        view?.configureHeaderView(headerView)
        view?.updatingViewSetState(isHidden: false)
        
        isLoading = true
        
        interactor?.setupObserver()
        
        interactor?.getFavoriteProducts()
        interactor?.getProducts(page: nextPage)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        if let product = products[safe: indexPath.row] {
            router?.openProductDetail(from: view, product: product)
        }
    }
    
    func scrollViewDidScrollToBottom() {
        nextPage += 1
        
        isLoading = true
        interactor?.getProducts(page: nextPage)
    }
    
    func refreshControllDidBeginRefreshing() { }

}

// MARK: - Products Interactor Output Protocol

extension ProductsPresenter: ProductsInteractorOutputProtocol {
    
    func favoriteProductsDidReceive(_ products: [Product]) {
        favoriteProducts = products
    }
    
    func productsDidReceive(_ products: [Product], hasMorePage: Bool) {
        view?.updatingViewSetState(isHidden: true)
        
        if products.isEmpty {
            if nextPage == 1 {
                let placeholder = placeholderViewFactory.createPlaceholder(context: .productsIsEmpty)
                view?.showPlaceholder(placeholder)
            }
        } else {
//            newProducts.forEach { product in
//                if let favoriteProduct = favoriteProducts.first(where: { $0.id == product.id }), let index = newProducts.firstIndex(where: { $0.id == favoriteProduct.id }) {
//                    newProducts[index].isFavorite = true
//                }
//            }
//
            self.products += products
            self.hasMorePage = hasMorePage
            
            view?.hidePlaceholder()
            view?.updateCollectionView()            
        }
        
        isLoading = false
    }
    
    func productReceivingDidFail(_ error: API.Error) {
        if nextPage == 1 {
            let action = {
                if let view = self.view {
                    self.router?.popViewController(view)
                }
            }
            
            view?.showAlert(with: "Ошибка", message: "Не удалось загрузить данные", actionTitle: "Вернуться", action: action)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.interactor?.getProducts(page: self?.nextPage)
            }
        }
    }
    
    func productDidSetAsFavorite(_ product: Product) {
//        guard let index = products.firstIndex(where: { $0.id == product.id }) else {
//            return
//        }
//
//        favoriteProducts += [product]
//
//        products[index].isFavorite = true
//        view?.updateRow(at: IndexPath(row: index, section: 0))
    }
    
    func productDidRemoveFromFavorite(at index: Int) {
//        let favoriteProduct = favoriteProducts.remove(at: index)
//
//        guard let productIndex = products.firstIndex(where: { $0.id == favoriteProduct.id }) else {
//            return
//        }
//
//        products[productIndex].isFavorite = false
//        view?.updateRow(at: IndexPath(row: productIndex, section: 0))
    }
    
    func sortingDidSetup() {
        // Update collection view
    }
    
    func filtersDidSetup() {
        // Update collection view
    }
    
}

// MARK: - Products Header View Delegate

extension ProductsPresenter: ProductListHeaderViewDelegate {
    
    func sortingButtonDidPress() {
        router?.openSortingModule(view)
    }
    
    func filterButtonDidPress() {
        router?.openFilterModule(view)
    }
    
}

// MARK: - Product Row Delegate

extension ProductsPresenter: ProductRowDelegate {
    
    func selectableItemDidSelect(at indexPath: IndexPath, isHighlighted: Bool) {
        if let product = products[safe: indexPath.row] {
            if isHighlighted {
                interactor?.setAsFavorite(product: product)
            } else {
                interactor?.setAsNotFavorite(product: product)
            }
        }
    }
    
}
