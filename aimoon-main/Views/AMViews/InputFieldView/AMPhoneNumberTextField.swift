//
//  AMPhoneNumberTextField.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 04.07.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import PhoneNumberKit

protocol AMPhoneNumberTextFieldDelegate: AnyObject {
    
    func textFieldDidChangeText(_ textField: PhoneNumberTextField)
    
}

final class AMPhoneNumberTextField: PhoneNumberTextField {
    
    weak var specificDelegate: AMPhoneNumberTextFieldDelegate?
    
    override var defaultRegion: String {
        get {
            return "RU"
        } set { } // swiftlint:disable:this unused_setter_value
    }
    
    var phoneNumberString: String? {
        guard let phoneNumber = phoneNumber else {
            return nil
        }
        
        let value = phoneNumberKit.format(phoneNumber, toType: .e164).replacingOccurrences(of: "+", with: "")
        return value
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Functions
    
    private func configure() {
        withPrefix = true
        withExamplePlaceholder = true
        
        maxDigits = 10
        
        let selector = #selector(textDidChange)
        addTarget(self, action: selector, for: .editingChanged)
    }
    
    @objc private func textDidChange() {
        specificDelegate?.textFieldDidChangeText(self)
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let replacementString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if currentRegion == "RU" && replacementString.isEmpty && textField.text?.count == 2 {
            return false
        }
        
        return super.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
    }
    
}
