//
//  CartPresenter.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class CartPresenter: CartPresenterProtocol {
    
    weak var view: CartViewProtocol?
    
    var interactor: CartInteractorInputProtocol?
    var router: CartRouterProtocol?
    
    var products: [Product] = []
    
    // MARK: - Life Cycle
    
    init(router: CartRouterProtocol, view: CartViewProtocol, interactor: CartInteractorInputProtocol) {
        self.interactor = interactor
        self.router = router
        
        self.view = view
    }
    
    func viewDidLoad() {
        interactor?.getCartProducts()
        interactor?.setupObserver()
    }
    
    func checkoutButtonDidPress() {
        if !products.isEmpty {
            router?.showOrderingViewController(from: view, products: products)
        } else {
            print("По какой-то причине список товаров пуст")
            view?.showAlert(with: "Ошибка", message: "Сейчас нельзя сделать заказ", actionTitle: "ОК")
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let product = products[safe: indexPath.row] else {
            return
        }
        
        router?.openProductDetail(from: view, product: product)
    }
    
}

// MARK: - Cart Interactor Output Protocol

extension CartPresenter: CartInteractorOutputProtocol {
    
    func cartProductsDidReceive(_ products: [Product]) {
        view?.hidePlaceholder()
        
        if !products.isEmpty {
            self.products = products
            view?.updateTableView()
            
            let totalPrice = products.map { $0.price }.reduce(0, +)
            let totalPriceValue = §"Сумма заказа: \(totalPrice)|₽"
            
            view?.setTotalAmountView(value: totalPriceValue)
            
            view?.setTableViewState(isHidden: false)
            view?.setBottomViewState(isHidden: false)
        } else {
            let placeholder = PlaceholderViewFactory().createPlaceholder(context: .cartIsEmpty, delegate: self)
            
            view?.showPlaceholder(placeholder)
            
            view?.setTableViewState(isHidden: true)
            view?.setBottomViewState(isHidden: true)
        }
    }
    
}

// MARK: - Placeholder Delegate

extension CartPresenter: PlaceholderDelegate {
    
    func actionButtonDidPress(_ context: PlaceholderViewFactory.Context) {
        if case .cartIsEmpty = context {
            Events.shared.report(.toCategoryButtonDidPress)
        }
    }
    
}

// MARK: - Placeholder Delegate

extension CartPresenter: CartRowDelegate {
    
    func cartRowRemovingButtonDidPress(at indexPath: IndexPath) {
        guard let product = products[safe: indexPath.row] else {
            return
        }
        
        interactor?.removeProductFromCart(product)
    }
    
}
