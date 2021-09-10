//
//  MainProtocols.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 08.07.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol MainRouterProtocol: BaseRouter {
    
    static func createModule() -> AMViewController
    
    func pushToTabBarViewController()
    
}

protocol MainViewProtocol: BaseView {
    
    var presenter: MainPresenterProtocol? { get set }
    
    func showLoadingView()
    
    func stopLoadingView()
    
}

protocol MainPresenterProtocol: AnyObject {
    
    var view: MainViewProtocol? { get set }
    
    var interactor: MainInteractorInputProtocol? { get set }
    
    var router: MainRouterProtocol? { get set }
    
    init(router: MainRouterProtocol, view: MainViewProtocol, interactor: MainInteractorInputProtocol)
    
    func viewDidLoad()
    
}

protocol MainInteractorInputProtocol: AnyObject {
    
    var presenter: MainInteractorOutputProtocol? { get set }
    
    func getConfiguration()
    
}

protocol MainInteractorOutputProtocol: AnyObject {
    
    func configurationDataDidReceive()
    
    func configurationDataReceivingDidFail(_ error: API.Error)
    
}
