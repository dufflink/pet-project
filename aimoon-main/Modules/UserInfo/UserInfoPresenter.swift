//
//  UserInfoPresenter.swift
//  aimoon-main
//

final class UserInfoPresenter: OrderingPresenter {

    override func viewDidLoad() {
        super.viewDidLoad()
        view?.setNavigationTitle("Мои данные")
        view?.setAcceptOrderButtonState(isHidden: true)
    }
    
}
