//
//  SuccessOrderingPresenter.swift
//  aimoon-main
//

final class SuccessOrderingPresenter: SuccessOrderingPresenterProtocol {

    weak var view: SuccessOrderingViewProtocol?

    var interactor: SuccessOrderingInteractorInputProtocol?
    var router: SuccessOrderingRouterProtocol?

    // MARK: - Life Cycle

    init(router: SuccessOrderingRouterProtocol, view: SuccessOrderingViewProtocol, interactor: SuccessOrderingInteractorInputProtocol) {
        self.router = router
        self.view = view

        self.interactor = interactor
    }

    func viewDidLoad() {
        guard let isUserAuth = interactor?.isUserAuth else {
            return
        }
        
        let factory = PlaceholderViewFactory()
        let placeholder = factory.createPlaceholder(context: .successOrdering(isAuth: isUserAuth), delegate: self)
        
        view?.showPlaceholder(placeholder)
    }

}

// MARK: - SuccessOrdering Interactor Output Protocol

extension SuccessOrderingPresenter: SuccessOrderingInteractorOutputProtocol {
    
}

// MARK: - Placeholder Delegate

extension SuccessOrderingPresenter: PlaceholderDelegate {
    
    func actionButtonDidPress(_ context: PlaceholderViewFactory.Context) {
        switch context {
            case let .successOrdering(isAuth):
                Events.shared.report(.successOrderingButtonDidPress(isAuth: isAuth))
                
                if isAuth {
                    SchedulingHelper.shared.scheduleTask(.openUserOrders)
                }
                
                router?.dismissViewController(view)
            default:
                break
        }
    }
    
}
