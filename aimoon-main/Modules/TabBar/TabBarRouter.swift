//
//  TabBarRouter.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 08.07.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class TabBarRouter: TabBarRouterProtocol {
    
    class func createModule() -> TabBarViewController {
        let view = R.storyboard.tabs.tabBarViewController()!
        
        let router = TabBarRouter()
        let presenter = TabBarPresenter(router: router, view: view)
        
        view.presenter = presenter
        return view
    }
    
    func changeSection(_ tabBar: TabBarViewProtocol, section: TabBarSection) {
        (tabBar as? UITabBarController)?.selectedIndex = section.rawValue
    }
    
}
