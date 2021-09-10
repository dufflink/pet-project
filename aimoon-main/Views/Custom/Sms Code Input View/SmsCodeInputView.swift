//
//  SmsCodeInputView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 06.07.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol SmsCodeInputViewDelegate: AnyObject {
    
    func smsCodeDidChange(_ smsCodeInputView: SmsCodeInputView, code: String?)
    
}

final class SmsCodeInputView: AMView {
    
    @IBOutlet weak private var fieldsStackView: UIStackView!
    
    weak var specificDelegate: SmsCodeInputViewDelegate?
    
    // MARK: - Properties
    
    private var numberViews: [SmsCodeNumberView] {
        return fieldsStackView.arrangedSubviews as? [SmsCodeNumberView] ?? []
    }
    
    private var maxIndex: Int {
        numberViews.count - 1
    }
    
    private var code: String {
        var code = ""
        
        numberViews.forEach {
            if let value = $0.value {
                code.append(value)
            }
        }
        
        code = code.trimmingCharacters(in: .whitespacesAndNewlines)
        return code
    }
    
    // MARK: - Life Cycle
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.smsCodeInputView)
    }
    
    convenience init(fieldsCount: Int) {
        self.init()
        fieldsStackView.clear()
        
        for _ in 0 ..< fieldsCount {
            let numberView = SmsCodeNumberView()
            numberView.specificDelegate = self
            
            NSLayoutConstraint.activate([
                numberView.widthAnchor.constraint(equalToConstant: 28),
                numberView.heightAnchor.constraint(equalToConstant: 36)
            ])
            
            fieldsStackView.addArrangedSubview(numberView)
        }
    }
    
    // MARK: - Functions
    
    func clear() {
        numberViews.forEach {
            $0.textField.text = nil
            $0.textField.isEnabled = false
        }
        
        setFirstInputViewAsResponder()
    }
    
    func setFirstInputViewAsResponder() {
        let firstTextField = numberViews.first?.textField
        
        firstTextField?.isEnabled = true
        firstTextField?.becomeFirstResponder()
    }
    
}

// MARK: - Sms Code Number View Delegate

extension SmsCodeInputView: SmsCodeNumberViewDelegate {
    
    func textFieldDidChangeText(_ textField: AMTextField) {
        var targetIndex = 0
        var shoudClearPreviousTextField = false
        
        guard let index = numberViews.firstIndex(where: { textField == $0.textField }), let numberView = numberViews[safe: index] else {
            return
        }
        
        if numberView.value != nil {
            targetIndex = index < maxIndex ? index + 1 : maxIndex
        } else {
            if index > 0 {
                targetIndex = index - 1
                shoudClearPreviousTextField = true
            }
        }
        
        specificDelegate?.smsCodeDidChange(self, code: code)
        
        guard let nextTextField = numberViews[safe: targetIndex]?.textField else {
            return
        }
        
        if shoudClearPreviousTextField {
            nextTextField.text = nil
        }
        
        nextTextField.isEnabled = true
        nextTextField.becomeFirstResponder()
        
        textField.isEnabled = false
    }
    
}
