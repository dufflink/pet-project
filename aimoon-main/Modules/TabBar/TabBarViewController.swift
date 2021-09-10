//
//  TabBarViewController.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 12.07.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    var presenter: TabBarPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Private Functions
    
    private func configureTabBar() {
        tabBar.tintColor = #colorLiteral(red: 1, green: 0.3098039216, blue: 0, alpha: 1)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.8274509804, green: 0.8274509804, blue: 0.8274509804, alpha: 1)
    }
    
    private func configureTabBarItems() {
        if let items = tabBar.items {
            items.forEach {
                $0.title = ""
                $0.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            }
        }
    }
    
}

// MARK: - Main View Protocol

extension TabBarViewController: TabBarViewProtocol {
    
    func setupViewControllers(_ viewControllers: [UIViewController]) {
        setViewControllers(viewControllers, animated: true)
        configureTabBarItems()
    }
    
}
