//
//  CategoriesProtocols.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol CategoriesRouterProtocol: BaseRouter {
    
    static func createModule() -> AMNavigationController
    
    static func createModuleViewController(categoryID: Int) -> AMViewController
    
    func openCategoriesViewController(from view: BaseView?, category: Category)
    
    func openProductsViewController(from view: BaseView?, category: Category)
    
}

protocol CategoriesViewProtocol: BaseView, WithPlaceholder, WithUpdatingView {
    
    var presenter: CategoriesPresenterProtocol? { get set }
    
    func updateTableView()
    
    func setTitle(_ title: String)
    
    func setAllProductsButtonTitle(_ title: String)
    
    func tablViewSetState(isHidden: Bool)
    
    func allProductsButtonSetState(isHidden: Bool)
    
}

protocol CategoriesPresenterProtocol: AnyObject {
    
    var view: CategoriesViewProtocol? { get set }
    
    var router: CategoriesRouterProtocol? { get set }
    
    init(router: CategoriesRouterProtocol, view: CategoriesViewProtocol, interactor: CategoriesInteractorInputProtocol)
    
    func viewDidLoad()
    
    func viewWillAppear()
    
    func didSelectCategory(at indexPath: IndexPath)
    
    func allProductsButtonDidPress()
    
    var categories: [Category] { get set }
    
    var categoriesCount: Int { get }
    
    var placeholderViewFactory: PlaceholderViewFactory { get set }
    
}

protocol CategoriesInteractorInputProtocol: AnyObject {
    
    var presenter: CategoriesInteractorOutputProtocol? { get set }
    
    var categoryID: Int? { get }
    
    var category: Category? { get }
    
    init(categoryID: Int?)
    
    func getCategory()
    
}

protocol CategoriesInteractorOutputProtocol: AnyObject {
    
    func categoriesDidReceive(categories: [Category])
    
    func cagegoriesReceivingDidFail(error: API.Error)
    
}
