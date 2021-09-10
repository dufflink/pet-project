//
//  OrderingViewController.swift
//  aimoon-main
//

import UIKit

class OrderingViewController: AMViewController {

    var presenter: OrderingPresenterProtocol?

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var acceptOrderButton: AMButton!
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    @IBAction func acceptOrderButtonDidPress(_ sender: Any) {
        presenter?.acceptOrderButtonDidPress()
    }
    
}

// MARK: - Ordering View Protocol

extension OrderingViewController: OrderingViewProtocol {
    
    func setActivityIndicatorState(isHidden: Bool) {
        isHidden ? activityIndicator.stopAnimating() : activityIndicator.startAnimating()
    }

    func setAcceptOrderButtonColor(_ color: UIColor?) {
        acceptOrderButton.currentBackgroundColor = color
    }
    
    func setAcceptOrderButtonState(isEnabled: Bool) {
        acceptOrderButton.isEnabled = isEnabled
    }
    
    func setAcceptOrderButtonState(isHidden: Bool) {
        acceptOrderButton.isHidden = isHidden
    }
    
    func setupInputFields(_ inputFields: [InputFieldView]) {
        stackView.clear()
        
        inputFields.forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
}
