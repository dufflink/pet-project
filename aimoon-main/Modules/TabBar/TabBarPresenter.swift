//
//  TabBarPresenter.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 12.07.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class TabBarPresenter: TabBarPresenterProtocol {
    
    weak var view: TabBarViewProtocol?
    var router: TabBarRouterProtocol?
    
    // MARK: - Life Cycle
    
    init(router: TabBarRouterProtocol, view: TabBarViewProtocol) {
        self.router = router
        self.view = view
        
        Events.shared.addTarget(self)
    }
    
    func viewDidLoad() {
        let viewControllers = configureViewControllers()
        view?.setupViewControllers(viewControllers)
    }
    
    func configureViewControllers() -> [UIViewController] {
        let homeModule = HomeRouter.createModule()
        homeModule.tabBarItem.image = #imageLiteral(resourceName: "Home")
        
        let categoriesModule = CategoriesRouter.createModule()
        categoriesModule.tabBarItem.image = #imageLiteral(resourceName: "Categories")
        
        let favoriteModule = FavoriteRouter.createModule()
        favoriteModule.tabBarItem.image = #imageLiteral(resourceName: "Favorite")
        
        let cartModule = CartRouter.createModule()
        cartModule.tabBarItem.image = #imageLiteral(resourceName: "Cart")
        
        let isAuth = LocaleStorage().isUserAuth
        
        let profileModule = isAuth ? ProfileRouter.createModule(isUserDidAuth: false) : AuthRouter.createModule()
        profileModule.tabBarItem.image = #imageLiteral(resourceName: "Profile")
        
        return [homeModule, categoriesModule, favoriteModule, cartModule, profileModule]
    }
    
}

// MARK: Eventable

extension TabBarPresenter: Eventable {
    
    func handleEvent(_ message: Events.Message) {
        switch message {
            case .bannerDidPress(let section):
                if let tabBar = view {
                    router?.changeSection(tabBar, section: section)
                }
            case .signInButtonDidPress:
                if let tabBar = view {
                    router?.changeSection(tabBar, section: .profile)
                }
            case .toCategoryButtonDidPress:
                if let tabBar = view {
                    router?.changeSection(tabBar, section: .categories)
                }
            case .toCartButtonDidPress:
                if let tabBar = view {
                    router?.changeSection(tabBar, section: .cart)
                }
            case .successOrderingButtonDidPress:
                if let tabBar = view {
                    router?.changeSection(tabBar, section: .profile)
                }
            default:
                break
        }
    }
    
}
