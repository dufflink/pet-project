//
//  OrderingPresenter.swift
//  aimoon-main
//

class OrderingPresenter: OrderingPresenterProtocol {

    weak var view: OrderingViewProtocol?

    var interactor: OrderingInteractorInputProtocol?
    var router: OrderingRouterProtocol?
    
    var inputViewFields: [InputFieldView]?

    // MARK: - Life Cycle

    required init(router: OrderingRouterProtocol, view: OrderingViewProtocol, interactor: OrderingInteractorInputProtocol) {
        self.router = router
        self.view = view

        self.interactor = interactor
    }

    func viewDidLoad() {
        view?.setActivityIndicatorState(isHidden: true)
        
        view?.setAcceptOrderButtonState(isEnabled: false)
        view?.setAcceptOrderButtonColor(R.color.placeholder())
        
        view?.setNavigationTitle("Оформление заказа")
        interactor?.getUserInfo()
        
        Events.shared.addTarget(self)
    }
    
    func acceptOrderButtonDidPress() {
        guard let name = inputViewFields?[safe: 0]?.value, let surname = inputViewFields?[safe: 1]?.value, let email = inputViewFields?[safe: 2]?.value, let phoneNumber = inputViewFields?[safe: 3]?.value else {
            return
        }
        
        let userInfo = UserInfo(name: name, surname: surname, email: email, phoneNumber: phoneNumber)
        interactor?.createOrder(userInfo: userInfo)
    }
    
    func setupInputViewFields(_ userInfo: UserInfo? = nil) {
        let factory = InputFieldViewFactory()
        
        let nameInputFieldView = factory.createNameInputField(title: "Имя", value: userInfo?.name, delegate: self)
        let surnameInputFieldView = factory.createNameInputField(title: "Фамилия", value: userInfo?.surname, delegate: self)
        
        let emailInputFieldView = factory.createEmailInputField(value: userInfo?.email, delegate: self)
        let phoneInputFieldView = factory.createPhoneInputField(value: userInfo?.phoneNumber, delegate: self)
        
        let fieldViews = [nameInputFieldView, surnameInputFieldView, emailInputFieldView, phoneInputFieldView]
        
        fieldViews.forEach {
            $0.heightAnchor.constraint(equalToConstant: 68).isActive = true
        }
        
        inputViewFields = fieldViews
        view?.setupInputFields(fieldViews)
    }

}

// MARK: - Ordering Interactor Output Protocol

extension OrderingPresenter: OrderingInteractorOutputProtocol {
    
    func orderingCreatinDidStart() {
        view?.hideKeyboard()
        view?.setActivityIndicatorState(isHidden: false)
        
    }
    
    func orderDidCreate() {
        view?.setActivityIndicatorState(isHidden: true)
        router?.showSeccessOrderingViewController(from: view)
    }
    
    func orderCreatingDidFail(_ error: API.Error) {
        // TODO: проработать варианты ошибок
        view?.setActivityIndicatorState(isHidden: true)
        view?.showAlert(with: "Ошибка", message: "Не удалось создать заказ", actionTitle: "ОК")
    }
    
    func userInfoDidReceive(_ userInfo: UserInfo?) {
        setupInputViewFields(userInfo)
        valueDidChange()
        
        if userInfo != nil, interactor?.localStorage.isUserAuth == true {
            inputViewFields?.forEach {
                $0.isEnabled = false
            }
        }
    }
    
}

extension OrderingPresenter: InputFieldViewDelegate {
    
    func valueDidChange(_ inputFieldView: InputFieldView? = nil) {
        var canCreateOrder = true
        
        inputViewFields?.forEach {
            if $0.isCorrectValue == false {
                canCreateOrder = false
            }
        }
        
        let color = canCreateOrder ? R.color.mainColor() : R.color.placeholder()
        
        view?.setAcceptOrderButtonState(isEnabled: canCreateOrder)
        view?.setAcceptOrderButtonColor(color)
    }
    
}

// MARK: - Eventable

extension OrderingPresenter: Eventable {
    
    func handleEvent(_ message: Events.Message) {
        switch message {
            case .successOrderingButtonDidPress:
                router?.popViewController(view)
            default:
                break
        }
    }
    
}
