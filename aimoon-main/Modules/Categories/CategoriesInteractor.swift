//
//  CategoriesInteractor.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

final class CategoriesInteractor: CategoriesInteractorInputProtocol {
    
    private(set) var categoryID: Int?
    private(set) var category: Category?
    
    weak var presenter: CategoriesInteractorOutputProtocol?
    
    // MARK: - Life Cycle
    
    init(categoryID: Int? = nil) {
        self.categoryID = categoryID
    }
    
    func getCategory() {
        if let categoryID = categoryID {
            API.shared.getCategory(id: categoryID).then { [weak self] result in
                self?.presenter?.categoriesDidReceive(categories: result.items)
            }.catch { [weak self] error in
                self?.presenter?.cagegoriesReceivingDidFail(error: error)
            }
        } else {
            let categories = LocaleStorage().mainCategories ?? []
            presenter?.categoriesDidReceive(categories: categories)
        }
    }
    
}
