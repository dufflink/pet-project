//
//  MainPresenter.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 08.07.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    
    var interactor: MainInteractorInputProtocol?
    var router: MainRouterProtocol?
    
    // MARK: - Life Cycle
    
    init(router: MainRouterProtocol, view: MainViewProtocol, interactor: MainInteractorInputProtocol) {
        self.router = router
        self.view = view
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.showLoadingView()
        interactor?.getConfiguration()
    }
    
}

// MARK: - Main Interactor Output Protocol

extension MainPresenter: MainInteractorOutputProtocol {
    
    func configurationDataDidReceive() {
        view?.stopLoadingView()
        router?.pushToTabBarViewController()
    }
    
    func configurationDataReceivingDidFail(_ error: API.Error) {
        view?.stopLoadingView()
        
        let message = error.code == .parsingFailure ? "Не удалось обработать информацию" : "Не удалось загрузить основные данные"
        view?.showAlert(with: "Ошибка", message: message, actionTitle: "Попробовать еще раз") { [weak self] in
            self?.view?.showLoadingView()
            self?.interactor?.getConfiguration()
        }
    }
    
}
