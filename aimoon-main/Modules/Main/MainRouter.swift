//
//  MainRouter.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 08.07.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class MainRouter: MainRouterProtocol {
    
    class func createModule() -> AMViewController {
        let mainViewController = R.storyboard.main.mainViewController()!
        
        let interactor = MainInteractor()
        let router = MainRouter()
        
        let presenter = MainPresenter(router: router, view: mainViewController, interactor: interactor)
        
        mainViewController.presenter = presenter
        interactor.presenter = presenter
        
        // Тут же указываются вспомогательные классы для intercator
        // Например interactor.networkManager = NetworkManager()
        
        return mainViewController
    }
    
    func pushToTabBarViewController() {
        let tabBar = TabBarRouter.createModule()
        Navigation.shared.setRootViewController(tabBar)
    }
    
}
