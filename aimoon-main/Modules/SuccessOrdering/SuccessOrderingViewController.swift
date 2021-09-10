//
//  SuccessOrderingViewController.swift
//  aimoon-main
//

final class SuccessOrderingViewController: AMViewController {

    var presenter: SuccessOrderingPresenterProtocol?
    
    var placeholder: AMShowableView?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

}

// MARK: - SuccessOrdering View Protocol

extension SuccessOrderingViewController: SuccessOrderingViewProtocol {

}
