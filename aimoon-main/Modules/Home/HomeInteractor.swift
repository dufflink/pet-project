//
//  HomeInteractor.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 09.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

final class HomeInteractor: HomeInteractorInputProtocol {
    
    weak var presenter: HomeInteractorOutputProtocol?
    
    var viewedListManager: ViewedListManagerInputProtocol?
    
    // MARK: - Home Interactor Input Protocol
    
    func getHomeItemModels() {
        if let homeItems = LocaleStorage().homeScreen?.homeItems {
            presenter?.homeItemsDidReceive(homeItems)
        } else {
            presenter?.homeItemsReceivingDidFail()
        }
    }
    
    func getViewedProducts(limit: Int? = nil) -> [Product] {
        return viewedListManager?.getViewedProducts(limit: limit) ?? []
    }
        
    func setupObserver() {
        viewedListManager?.activateNotification()
    }
}

extension HomeInteractor: ViewedListManagerOutputProtocol {
    
    func viewedProductsDidUpdate() {
        presenter?.viewedProductsDidUpdate()
    }
    
}
