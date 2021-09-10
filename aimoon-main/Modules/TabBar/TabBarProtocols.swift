//
//  TabBarProtocols.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 12.07.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol TabBarRouterProtocol: BaseRouter {
    
    static func createModule() -> TabBarViewController
    
    func changeSection(_ tabBar: TabBarViewProtocol, section: TabBarSection)
    
}

protocol TabBarViewProtocol: AnyObject {
    
    var presenter: TabBarPresenterProtocol? { get set }
    
    func setupViewControllers(_ viewControllers: [UIViewController])
    
}

protocol TabBarPresenterProtocol: AnyObject {
    
    var view: TabBarViewProtocol? { get set }
    
    var router: TabBarRouterProtocol? { get set }
    
    init(router: TabBarRouterProtocol, view: TabBarViewProtocol)
    
    func viewDidLoad()
    
    func configureViewControllers() -> [UIViewController]
    
}

protocol TabBarInteractorInputProtocol: AnyObject {
    
    var presenter: TabBarInteractorOutputProtocol? { get set }
    
}

protocol TabBarInteractorOutputProtocol: AnyObject { }
