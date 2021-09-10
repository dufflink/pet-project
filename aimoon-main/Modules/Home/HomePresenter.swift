//
//  HomePresenter.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 09.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewProtocol?
    
    var interactor: HomeInteractorInputProtocol?
    var router: HomeRouterProtocol?
    
    var itemsFactory: HomeItemViewFactory
    
    // MARK: - Life Cycle
    
    init(router: HomeRouterProtocol, view: HomeViewProtocol, interactor: HomeInteractorInputProtocol) {
        self.router = router
        self.view = view
        
        self.interactor = interactor
        itemsFactory = HomeItemViewFactory()
    }
    
    func viewDidLoad() {
        interactor?.getHomeItemModels()
        interactor?.setupObserver()
    }
    
}

// MARK: - Home Interactor Output Protocol

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func viewedProductsDidUpdate() {
        interactor?.getHomeItemModels()
    }
    
    func homeItemsDidReceive(_ items: [HomeItem]) {
        guard !items.isEmpty else {
            showPlaceholder()
            return
        }
        
        var views = [UIView]()
        
        items.forEach { item in
            if let type = HomeItem.ItemType(rawValue: item.type) {
                switch type {
                    case .rectangle:
                        let banner = itemsFactory.createRectangleBanner(from: item, delegate: self)
                        views += [banner]
                    case .mosaic:
                        if let banner = itemsFactory.createMosaicBanner(from: item, delegate: self) {
                            views += [banner]
                        }
                    case .carousel, .viewedProducts:
                        var products: [Product] = []
                        
                        if let source = HomeItem.Source(rawValue: item.source), source == .local, let interactor = interactor {
                            products = interactor.getViewedProducts(limit: item.count)
                        } else if let homeItemProducts = item.products {
                            products = homeItemProducts
                        }

                        if let banner = itemsFactory.createCarouselBanner(from: item, products: products, delegate: self) {
                            views += [banner]
                        }
                        
                }
            }
        }
        
        view?.setupViews(views)
    }
    
    func homeItemsReceivingDidFail() {
        showPlaceholder()
    }
    
    private func showPlaceholder() {
        let factory = PlaceholderViewFactory()
        let placeholder = factory.createPlaceholder(context: .homeItemsIsEmpty)
        
        view?.stackViewSetState(isHidden: true)
        view?.showPlaceholder(placeholder)
    }
    
}

// MARK: - Banner Delegate

extension HomePresenter: BannerDelegate {
    
    func bannerDidPress(_ banner: Banner) {
        guard let route = Banner.Route(route: banner.route) else {
            return
        }
        
        let openTabBarSection = {
            let tabBarSection = TabBarSection(route: route)
            let message = Events.Message.bannerDidPress(tabBarSection)
            
            Events.shared.report(message)
        }
        
        guard let routeParam = banner.routeParam else {
            openTabBarSection()
            return
        }
        
        switch route {
            case .category:
                router?.openCategoriesViewController(from: view, categoryID: routeParam)
            case .product:
                router?.openProductDetail(from: view, productID: routeParam)
            default:
                openTabBarSection()
        }
        
    }
    
}

extension HomePresenter: ProductsCollectionViewDelegate {
    
    func productDidSelect(_ product: Product) {
        router?.openProductDetail(from: view, productID: product.id)
    }
    
}
