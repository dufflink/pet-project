//
//  AuthPresenter.swift
//  aimoon-main
//

final class AuthPresenter: AuthPresenterProtocol {

    weak var view: AuthViewProtocol?

    var interactor: AuthInteractorInputProtocol?
    var router: AuthRouterProtocol?
    
    var phoneNumber: String?
    var formattedPhoneNumber: String?

    // MARK: - Life Cycle

    init(router: AuthRouterProtocol, view: AuthViewProtocol, interactor: AuthInteractorInputProtocol) {
        self.router = router
        self.view = view

        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.signInButtonSetState(isEnabled: false)
    }
    
    func authButtonDidPress(phoneNumber: String, formattedPhoneNumber: String) {
        self.phoneNumber = phoneNumber
        self.formattedPhoneNumber = formattedPhoneNumber
        
        interactor?.getSmsCode(phoneNumber: phoneNumber)
    }
    
    func phoneNumberTextDidChange(_ text: String?) {
        view?.signInButtonSetState(isEnabled: text != nil)
    }

}

// MARK: - Auth Interactor Output Protocol

extension AuthPresenter: AuthInteractorOutputProtocol {
    
    func smsCodeDidSendToUser() {
        guard let phoneNumber = phoneNumber, let formattedPhoneNumber = formattedPhoneNumber else {
            return
        }
        
        router?.openSmsCodeInputViewController(from: view, phoneNumber: phoneNumber, formattedPhoneNumber: formattedPhoneNumber)
    }
    
    func smsCodeSendingDidFail(_ error: API.Error) {
        let title = "Ошибка"
        var message = "\(error.message ?? "")"
        
        if error.statusCode == .notFound {
            message = "Аккаунта с таким номером телефона не существует"
        }
        
        view?.updatingViewSetState(isHidden: true)
        view?.showAlert(with: title, message: message, actionTitle: "ОК")
    }
    
}
