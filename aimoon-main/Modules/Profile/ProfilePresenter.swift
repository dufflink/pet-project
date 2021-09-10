//
//  ProfilePresenter.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfileViewProtocol?
    
    var interactor: ProfileInteractorInputProtocol?
    var router: ProfileRouterProtocol?
    
    var menuRows: [ProfileMenu]?
    
    var menuRowsCount: Int {
        return menuRows?.count ?? 0
    }
    
    var isUserDidAuth: Bool
    
    // MARK: - Life Cycle
    
    init(router: ProfileRouterProtocol, view: ProfileViewProtocol, interactor: ProfileInteractorInputProtocol, isUserDidAuth: Bool) {
        self.interactor = interactor
        self.router = router
        
        self.view = view
        self.isUserDidAuth = isUserDidAuth
    }
    
    func viewDidLoad() {
        interactor?.getMenuRows()
        
        if isUserDidAuth {
            interactor?.syncLocalDataWithRemoteServer()
        }
        
        SchedulingHelper.shared.delegate = self
    }
    
    func viewDidAppear() {
        Events.shared.report(.profileViewDidAppear)
    }
    
    func logoutButtonDidPress() {
        let controller = UIAlertController(title: "Выход", message: "Вы уверены, что хотите выйти из аккаунта?", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Выйти", style: .destructive) { [weak self] _ in
            self?.interactor?.logout()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)

        controller.addAction(action)
        controller.addAction(cancelAction)
        
        view?.showAlert(controller)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        if let profileMenu = menuRows?[safe: indexPath.row] {
            switch profileMenu {
                case .userInfo:
                    router?.openUserInfoViewController(from: view)
                case .orders:
                    router?.openOrdersViewController(from: view)
                case .aboutApp:
                    router?.openAboutAppViewController(from: view)
            }
        }
    }
    
}

// MARK: - Profile Interactor Output Protocol

extension ProfilePresenter: ProfileInteractorOutputProtocol {
    
    func menuRowsDidReceive(_ menuRows: [ProfileMenu]) {
        self.menuRows = menuRows
        view?.updateTableView()
    }
    
    func userDidLogout() {
        router?.openAuthViewController(from: view)
        
        Events.shared.report(.userDidLogout)
        interactor?.clearFavoriteProductList()
    }
    
    func dataSyncDidStart() {
        view?.syncingLabelSetState(isHidden: false)
    }
    
    func dataDidSync(_ result: OperationResult) {
        view?.syncingLabelSetState(isHidden: true)
        
        switch result {
            case .success:
                Events.shared.report(.remoteProductsDidSync)
            case .fail(let error):
                switch error {
                    case .serverError:
                        print("Ошибка сервера. Не удалось синхронизировать данные на сервере")
                    case .fetchingError:
                        print("Ошибка базы данных. Не удалось получить данные из базы")
                    default:
                        break
                }
        }
    }
    
}

// MARK: - Schedulable

extension ProfilePresenter: Schedulable {
    
    func completeTask(_ task: SchedulingHelper.Task) {
        if task == .openUserOrders {
            router?.openOrdersViewController(from: view)
        }
    }
    
}
