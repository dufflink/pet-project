//
//  AuthViewController.swift
//  aimoon-main
//

import PhoneNumberKit

final class AuthViewController: AMViewController {

    var presenter: AuthPresenterProtocol?
    var updatingView: UpdatingView?
    
    @IBOutlet private weak var phoneTextField: AMPhoneNumberTextField!
    @IBOutlet private weak var centerView: UIView!
    
    @IBOutlet private weak var signInButton: AMButton!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationTitle = "Вход"
    }
    
    override func configureView() {
        super.configureView()
        phoneTextField.specificDelegate = self
        view.addTapperForEndEditing(delegate: self)
    }
    
    // MARK: - Builder Actions

    @IBAction func signInButtonDidPress(_ sender: Any) {
        guard let phoneNumber = phoneTextField.phoneNumberString, let formattedPhoneNumber = phoneTextField.phoneNumber?.numberString else {
            return
        }
        
        presenter?.authButtonDidPress(phoneNumber: phoneNumber, formattedPhoneNumber: formattedPhoneNumber)
    }
    
}

// MARK: - Auth View Protocol

extension AuthViewController: AuthViewProtocol {
    
    func signInButtonSetState(isEnabled: Bool) {
        signInButton.isEnabled = isEnabled
    }
    
    func updatingViewSetState(isHidden: Bool) {
        if isHidden {
            updatingView?.hide()
        } else {
            updatingView = UpdatingView()
            updatingView?.show(in: centerView)
        }
    }
    
}

// MARK: - UIGesture Recognizer Delegate

extension AuthViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view is UIButton {
            return false
        }
        
        return true
    }
    
}

// MARK: - AMPhoneNumber Text Field Delegate

extension AuthViewController: AMPhoneNumberTextFieldDelegate {
    
    func textFieldDidChangeText(_ textField: PhoneNumberTextField) {
        presenter?.phoneNumberTextDidChange(textField.phoneNumber?.numberString)
    }
    
}
