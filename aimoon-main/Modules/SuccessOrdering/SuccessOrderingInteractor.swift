//
//  SuccessOrderingInteractor.swift
//  aimoon-main
//

final class SuccessOrderingInteractor: SuccessOrderingInteractorInputProtocol {

    weak var presenter: SuccessOrderingInteractorOutputProtocol?
    
    var localStorage = LocaleStorage()
    
    var isUserAuth: Bool {
        return localStorage.isUserAuth
    }

}
