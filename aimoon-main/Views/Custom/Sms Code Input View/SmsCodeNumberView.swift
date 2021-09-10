//
//  SmsCodeNumberView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 06.07.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol SmsCodeNumberViewDelegate: AnyObject {
    
    func textFieldDidChangeText(_ textField: AMTextField)
    
}

@IBDesignable final class SmsCodeNumberView: AMView {
    
    @IBOutlet weak var textField: AMTextField!
    
    weak var specificDelegate: SmsCodeNumberViewDelegate?
    
    // MARK: - Properties
    
    var value: String? {
        return textField.text?.isEmpty == true ? nil : textField.text
    }
    
    // MARK: - Life Cycle
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.smsCodeNumberView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Functions
    
    private func configure() {
        textField.delegate = self
        textField.specificDelegate = self
        
        textField.isEnabled = false
        
        let selector = #selector(textDidChange)
        textField.addTarget(self, action: selector, for: .editingChanged)
    }
    
    @objc private func textDidChange() {
        specificDelegate?.textFieldDidChangeText(textField)
    }
    
}

// MARK: - UITextField Delegate

extension SmsCodeNumberView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = (textField.text ?? "") as NSString? else {
            return false
        }

        let newString = text.replacingCharacters(in: range, with: string)
        return newString.count <= 1
    }
    
}

// MARK: - AMTextField Delegate

extension SmsCodeNumberView: AMTextFieldDelegate {
    
    func deleteButtonDidPress(_ textField: AMTextField) {
        specificDelegate?.textFieldDidChangeText(textField)
    }
    
}
