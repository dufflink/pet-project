//
//  SmsCodePresenter.swift
//  aimoon-main
//

final class SmsCodePresenter: SmsCodePresenterProtocol {

    weak var view: SmsCodeViewProtocol?

    var interactor: SmsCodeInteractorInputProtocol?
    var router: SmsCodeRouterProtocol?
    
    var smsCodeLenght: Int {
        return 4
    }

    // MARK: - Life Cycle

    init(router: SmsCodeRouterProtocol, view: SmsCodeViewProtocol, interactor: SmsCodeInteractorInputProtocol) {
        self.router = router
        self.view = view

        self.interactor = interactor
    }
    
    // MARK: - Functions

    func viewDidLoad() {
        configureSmsCodeView()
        
        guard let formattedPhoneNumber = interactor?.formattedPhoneNumber else {
            return
        }
        
        let text = §"Мы отправили код в SMS на номер\n\(formattedPhoneNumber)^._Пожалуйста,_введите_его."
        view?.configureHintView(text: text)
    }
    
    private func configureSmsCodeView() {
        let smsCodeInputView = SmsCodeInputView(fieldsCount: smsCodeLenght)
        smsCodeInputView.specificDelegate = self
        
        view?.setSmsCodeInputView(smsCodeInputView)
    }

}

// MARK: - SmsCode Interactor Output Protocol

extension SmsCodePresenter: SmsCodeInteractorOutputProtocol {
    
    func userInfoDidReceived() {
        view?.updatingViewSetState(isHidden: true)

        router?.openProfileViewController(from: view)
        Events.shared.report(.userDidAuth)
    }
    
    func authDidFail(_ error: API.Error) {
        let title = "Ошибка"
        var message = "\(error.message ?? "")"
        
        if error.statusCode == .notFound {
            message = "SMS-код не верный"
        }
        
        view?.clearSmsCodeInputView()
        view?.updatingViewSetState(isHidden: true)
        
        view?.showAlert(with: title, message: message, actionTitle: "ОК")
    }

    func userInfoRecevingDidFail(_ error: API.Error) {
        view?.updatingViewSetState(isHidden: true)
        view?.showAlert(with: "Ошибка", message: "Не удалось загрузить информацию о пользователе", actionTitle: "ОК")
    }
    
}

// MARK: - Sms Code Input View Delegate

extension SmsCodePresenter: SmsCodeInputViewDelegate {
    
    func smsCodeDidChange(_ smsCodeInputView: SmsCodeInputView, code: String?) {
        if let code = code, code.count == smsCodeLenght {
            interactor?.auth(code: code)
        }
    }
    
}
