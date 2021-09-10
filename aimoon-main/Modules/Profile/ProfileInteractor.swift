//
//  ProfileInteractor.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

final class ProfileInteractor: ProfileInteractorInputProtocol {
    
    weak var presenter: ProfileInteractorOutputProtocol?
    
    var syncManager: SyncManagerFavoriteProducts?
    
    func getMenuRows() {
        let menuRows: [ProfileMenu] = [.userInfo, .orders]
        presenter?.menuRowsDidReceive(menuRows)
    }
    
    func logout() {
        let localeStorage = LocaleStorage()
        
        localeStorage.accessToken = nil
        localeStorage.userInfo = nil
        
        presenter?.userDidLogout()
    }
    
    // В будущем тут будет использоваться глобальный синхронизатор
    
    func syncLocalDataWithRemoteServer() {
        presenter?.dataSyncDidStart()
        
        syncManager?.syncObjects { [weak self] result in
            if case .success = result {
                self?.syncManager?.getAndSaveSyncedObjects { error  in
                    if let error = error {
                        self?.presenter?.dataDidSync(.fail(.serverError(error)))
                        return
                    }
                    
                    self?.presenter?.dataDidSync(.success)
                }
            } else {
                self?.presenter?.dataDidSync(result)
            }
        }
    }
    
    func clearFavoriteProductList() {
        let productManager = ProductManager()
        productManager.clearFavoriteProductList()
    }
    
}
