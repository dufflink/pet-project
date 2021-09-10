//
//  MainIntercator.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 08.07.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

final class MainInteractor: MainInteractorInputProtocol {
    
    weak var presenter: MainInteractorOutputProtocol?
    
    func getConfiguration() {
        API.shared.getCategory().then { [weak self] result in
            self?.save(result.items)

            API.shared.getHomeScreen().then { [weak self] homeScreen in
                self?.save(homeScreen)
                self?.presenter?.configurationDataDidReceive()
            }.catch { [weak self] error in
                self?.presenter?.configurationDataReceivingDidFail(error)
            }
        }.catch { [weak self] error in
            self?.presenter?.configurationDataReceivingDidFail(error)
        }
    }
    
    // MARK: - Private Functions
    
    private func save(_ homeScreen: HomeScreen) {
        LocaleStorage().homeScreen = homeScreen
    }
    
    private func save(_ categories: [Category]) {
        LocaleStorage().mainCategories = categories
    }
    
}
