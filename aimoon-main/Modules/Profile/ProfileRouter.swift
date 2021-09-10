//
//  ProfileRouter.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class ProfileRouter: ProfileRouterProtocol {
    
    class func createModule(isUserDidAuth: Bool) -> AMNavigationController {
        let navigationController = R.storyboard.profile.profileNavigationController()!

        if let view = navigationController.viewControllers.first as? ProfileViewProtocol {
            let syncManager = SyncManagerFavoriteProducts()
            
            let interactor = ProfileInteractor()
            interactor.syncManager = syncManager
            
            let router = ProfileRouter()
            let presenter = ProfilePresenter(router: router, view: view, interactor: interactor, isUserDidAuth: isUserDidAuth)
            
            view.presenter = presenter
            interactor.presenter = presenter
        }
        
        return navigationController
    }
    
    class func createModuleController(isUserDidAuth: Bool) -> AMViewController {
        let view = R.storyboard.profile.profileViewController()!
        let syncManager = SyncManagerFavoriteProducts()
        
        let interactor = ProfileInteractor()
        interactor.syncManager = syncManager
        
        let router = ProfileRouter()
        let presenter = ProfilePresenter(router: router, view: view, interactor: interactor, isUserDidAuth: isUserDidAuth)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
    
    func openUserInfoViewController(from view: BaseView?) {
        let userInfoModule = UserInfoRouter.createModule()
        view?.push(viewController: userInfoModule)
    }
    
    func openOrdersViewController(from view: BaseView?) {
        let orderListModule = OrderListRouter.createModule()
        view?.push(viewController: orderListModule)
    }
    
    func openAuthViewController(from view: BaseView?) {
        let authModule = AuthRouter.createModuleController()
        view?.push(viewController: authModule, clearBackStack: true, animated: true)
    }
    
    func openAboutAppViewController(from view: BaseView?) {
        
    }
    
}
