//
//  ProfileProtocols.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol ProfileRouterProtocol: BaseRouter {
    
    static func createModule(isUserDidAuth: Bool) -> AMNavigationController
    
    static func createModuleController(isUserDidAuth: Bool) -> AMViewController
    
    func openUserInfoViewController(from view: BaseView?)
    
    func openOrdersViewController(from view: BaseView?)
    
    func openAuthViewController(from view: BaseView?)
    
    func openAboutAppViewController(from view: BaseView?)
    
}

protocol ProfileViewProtocol: BaseView {
    
    var presenter: ProfilePresenterProtocol? { get set }
    
    func updateTableView()
    
    func showAlert(_ alert: UIAlertController)
    
    func syncingLabelSetState(isHidden: Bool)
    
}

protocol ProfilePresenterProtocol: AnyObject {
    
    var view: ProfileViewProtocol? { get set }
    
    var router: ProfileRouterProtocol? { get set }
    
    init(router: ProfileRouterProtocol, view: ProfileViewProtocol, interactor: ProfileInteractorInputProtocol, isUserDidAuth: Bool)
    
    func viewDidLoad()
    
    func viewDidAppear()
    
    func didSelectRow(at indexPath: IndexPath)
    
    func logoutButtonDidPress()
    
    var isUserDidAuth: Bool { get }
    
    var menuRows: [ProfileMenu]? { get set }
    
    var menuRowsCount: Int { get }
    
}

protocol ProfileInteractorInputProtocol: AnyObject {
    
    var presenter: ProfileInteractorOutputProtocol? { get set }
    
    var syncManager: SyncManagerFavoriteProducts? { get set }
    
    func getMenuRows()
    
    func syncLocalDataWithRemoteServer()
    
    func logout()
    
    func clearFavoriteProductList()
    
}

protocol ProfileInteractorOutputProtocol: AnyObject {
    
    func menuRowsDidReceive(_ menuRows: [ProfileMenu])
    
    func userDidLogout()
    
    func dataDidSync(_ result: OperationResult)
    
    func dataSyncDidStart()
    
}
