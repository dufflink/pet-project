//
//  CategoriesPresenter.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class CategoriesPresenter: CategoriesPresenterProtocol {
    
    weak var view: CategoriesViewProtocol?
    
    var interactor: CategoriesInteractorInputProtocol?
    var router: CategoriesRouterProtocol?
    
    // MARK: - Public Properties
    
    var categories: [Category] = []
    var placeholderViewFactory: PlaceholderViewFactory
    
    var categoriesCount: Int {
        return categories.count
    }
    
    // MARK: - Life Cycle
    
    init(router: CategoriesRouterProtocol, view: CategoriesViewProtocol, interactor: CategoriesInteractorInputProtocol) {
        self.interactor = interactor
        self.router = router
        
        self.view = view
        placeholderViewFactory = PlaceholderViewFactory()
    }
    
    func viewDidLoad() {
        view?.updatingViewSetState(isHidden: false)
        interactor?.getCategory()
    }
    
    func viewWillAppear() {
        if let title = interactor?.category?.name {
            view?.setNavigationTitle(title)
            let buttonTitle = "Все товары \"\(title)\""
            
            view?.setAllProductsButtonTitle(buttonTitle)
            view?.allProductsButtonSetState(isHidden: false)
        } else {
            view?.setNavigationTitle("Категории")
            view?.allProductsButtonSetState(isHidden: true)
        }
    }
    
    func didSelectCategory(at indexPath: IndexPath) {
        if let category = categories[safe: indexPath.row] {
            if category.hasSubCategory {
                router?.openCategoriesViewController(from: view, category: category)
            } else {
                router?.openProductsViewController(from: view, category: category)
            }
        }
    }
    
    func allProductsButtonDidPress() {
        if let category = interactor?.category {
            router?.openProductsViewController(from: view, category: category)
        }
    }
    
}

// MARK: - Categories Interactor Output Protocol

extension CategoriesPresenter: CategoriesInteractorOutputProtocol {
    
    func categoriesDidReceive(categories: [Category]) {
        self.categories = categories
        view?.updatingViewSetState(isHidden: true)
        
        if categories.isEmpty {
            view?.tablViewSetState(isHidden: true)
            
            let placeholder = placeholderViewFactory.createPlaceholder(context: .categoriesIsEmpty)
            view?.showPlaceholder(placeholder)
        } else {
            view?.hidePlaceholder()
            view?.updateTableView()
        }
    }
    
    func cagegoriesReceivingDidFail(error: API.Error) {
        let action = {
            if let view = self.view {
                self.router?.popViewController(view)
            }
        }
        
        view?.showAlert(with: "Ошибка", message: "Не удалось загрузить данные", actionTitle: "Вернуться", action: action)
    }
    
}
