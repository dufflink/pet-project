//
//  AuthInteractor.swift
//  aimoon-main
//

final class AuthInteractor: AuthInteractorInputProtocol {

    weak var presenter: AuthInteractorOutputProtocol?
    
    var localStorage = LocaleStorage()
    
    func getSmsCode(phoneNumber: String) {
        API.shared.getSmsCode(phoneNumber: phoneNumber).then { [weak self] _ in
            self?.presenter?.smsCodeDidSendToUser()
        }.catch { [weak self] error in
            self?.presenter?.smsCodeSendingDidFail(error)
        }
    }
    
}
