//
//  FavoritePresenter.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import RealmSwift
import UIKit

final class FavoritePresenter: FavoritePresenterProtocol {
    
    weak var view: ProductListViewProtocol?
    
    var interactor: FavoriteInteractorInputProtocol?
    var router: FavoriteRouterProtocol?
    
    var favoriteProducts: [Product] = []
    var products: [Product] = []
    
    var placeholderViewFactory: PlaceholderViewFactory

    var productsCount: Int {
        return products.count
    }
    
    var isUserAuth: Bool {
        return LocaleStorage().isUserAuth
    }
    
    var needShowFavoriteItem = true
    var isLoading = false
    
    var hasMorePage = false
    var nextPage = 1
    
    // MARK: - Life Cycle
    
    init(router: FavoriteRouterProtocol, view: ProductListViewProtocol, interactor: FavoriteInteractorInputProtocol) {
        self.interactor = interactor
        self.router = router
        
        self.view = view
        
        placeholderViewFactory = PlaceholderViewFactory()
    }
    
    func viewDidLoad() {
        Events.shared.addTarget(self)
        view?.setNavigationTitle("Избранное")
        
        if isUserAuth {
            reloadData()
        } else {
            interactor?.setupObserver()
            interactor?.getLocalFavoriteProducts()
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        if let product = products[safe: indexPath.row] {
            router?.openProductDetail(from: view, product: product)
        }
    }
    
    func refreshControllDidBeginRefreshing() {
        isLoading = true
        
        interactor?.removeObserver()
        interactor?.refreshFavoriteProducts()
    }
    
    func scrollViewDidScrollToBottom() { }
    
    // MARK: - Private Functions
    
    private func createPlaceholder() -> PlaceholderView {
        let placeholder: PlaceholderView
        
        if !isUserAuth {
            placeholder = placeholderViewFactory.createPlaceholder(context: .favoriteIsEmpty(isAuth: false), delegate: self)
        } else {
            placeholder = placeholderViewFactory.createPlaceholder(context: .favoriteIsEmpty(isAuth: true))
        }
        
        return placeholder
    }
    
    private func reloadData() {
        view?.setRefreshControl()
        view?.collectionViewSetState(isHidden: true)
        
        view?.hidePlaceholder()
        view?.updatingViewSetState(isHidden: false)
        
        isLoading = true
        
        interactor?.removeObserver()
        interactor?.getRemoteFavoriteProducts()
    }
    
}

// MARK: - Favorite Interactor Output Protocol

extension FavoritePresenter: FavoriteInteractorOutputProtocol {
    
    func favoriteProductsDidReceive(_ products: [Product], hasMorePage: Bool) {
        view?.updatingViewSetState(isHidden: true)
        
        if !products.isEmpty {
            self.products = products
            
            view?.collectionViewSetState(isHidden: false)
            view?.updateCollectionView()
        } else {
            let placeholder = createPlaceholder()
            view?.showPlaceholder(placeholder)
        }
    }
    
    func productDidSetAsFavorite(_ product: Product) {
        products += [product]
        
        view?.collectionViewSetState(isHidden: false)
        
        view?.updateCollectionView()
        view?.hidePlaceholder()
    }
    
    func productDidRemoveFromFavorite(at index: Int) {
        products.remove(at: index)
        view?.removeRow(at: IndexPath(row: index, section: 0))
        
        if products.isEmpty {
            let placeholder = createPlaceholder()
            view?.showPlaceholder(placeholder)
        }
    }
    
    func gettingRemoteFavoriteProductsDidFinish() {
        interactor?.getLocalFavoriteProducts()
        
        interactor?.setupObserver()
        isLoading = false
    }
    
    func gettingRemoteFavoriteProductsDidFail(_ error: API.Error?) {
        isLoading = false
        
        view?.updatingViewSetState(isHidden: true)
        view?.hidePlaceholder()
        
        let placeholder = placeholderViewFactory.createPlaceholder(context: .loadingFavoriteProductsDidFail, delegate: self)
        view?.showPlaceholder(placeholder)
    }
    
    func refreshingFavoriteProductsDidFinish() {
        view?.stopRefreshing()
        interactor?.getLocalFavoriteProducts()
        
        interactor?.setupObserver()
        isLoading = false
    }
    
    func refreshingFavoriteProductsDidFail(_ error: API.Error?) {
        view?.stopRefreshing()
        
        interactor?.setupObserver()
        isLoading = false
        
        view?.showAlert(with: "Ошибка", message: "Не удалось обновить список избранных товаров", actionTitle: "ОК")
    }
    
}

// MARK: - Placeholder Delegate

extension FavoritePresenter: PlaceholderDelegate {
    
    func actionButtonDidPress(_ context: PlaceholderViewFactory.Context) {
        switch context {
            case .favoriteIsEmpty:
                Events.shared.report(.signInButtonDidPress)
            case .loadingFavoriteProductsDidFail:
                reloadData()
            default:
                break
        }
        
    }
    
}

// MARK: - Product Row Delegate

extension FavoritePresenter: ProductRowDelegate {
    
    func selectableItemDidSelect(at indexPath: IndexPath, isHighlighted: Bool) {
        if let product = products[safe: indexPath.row] {
            isHighlighted ? interactor?.setAsFavorite(product: product) : interactor?.setAsNotFavorite(product: product)
        }
    }
    
}

// MARK: - Eventable

extension FavoritePresenter: Eventable {
    
    func handleEvent(_ message: Events.Message) {
        switch message {
            case .userDidLogout:
                hasMorePage = false
                
                view?.updateCollectionView()
                view?.removeRefreshControl()
                
                if products.isEmpty {
                    view?.hidePlaceholder()
                    
                    let placeholder = createPlaceholder()
                    view?.showPlaceholder(placeholder)
                }
            case .remoteProductsDidSync:
                reloadData()
            default:
                break
        }
    }
    
}
