//
//  SmsCodeViewController.swift
//  aimoon-main
//

import UIKit

final class SmsCodeViewController: AMViewController {

    @IBOutlet weak private var centerView: UIView!
    @IBOutlet weak private var hintView: UILabel!
    
    var smsCodeInputView: SmsCodeInputView?
    
    var updatingView: UpdatingView?
    var presenter: SmsCodePresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationTitle = "Проверка"
        smsCodeInputView?.setFirstInputViewAsResponder()
    }

}

// MARK: - SmsCode View Protocol

extension SmsCodeViewController: SmsCodeViewProtocol {

    func setSmsCodeInputView(_ view: SmsCodeInputView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        centerView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: centerView.centerYAnchor),
            view.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),
            
            hintView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -8)
        ])
        
        smsCodeInputView = view
    }
    
    func clearSmsCodeInputView() {
        smsCodeInputView?.clear()
    }
    
    func configureHintView(text: String) {
        hintView.text = text
    }
    
}
