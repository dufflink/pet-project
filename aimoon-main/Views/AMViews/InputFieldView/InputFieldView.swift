//
//  InputFieldView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 05.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol InputFieldViewDelegate: AnyObject {
    
    func valueDidChange(_ inputFieldView: InputFieldView?)
    
}

class InputFieldView: AMView {
    
    @IBOutlet private(set) weak var titleView: UILabel!
    @IBOutlet private(set) weak var textField: AMTextField!
    
    @IBOutlet private(set) weak var textFieldLeading: NSLayoutConstraint!
    
    weak var specificDelegate: InputFieldViewDelegate?
    private var model: InputFieldModel?
    
    var value: String? {
        return model?.value
    }
    
    override var isEnabled: Bool {
        get {
            return textField.isEnabled
        } set {
            textField.isEnabled = newValue
        }
    }
    
    var isCorrectValue: Bool? {
        return model?.isCorrectValue
    }
    
    // MARK: - Life Cycle
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.inputFieldView)
    }
    
    convenience init(model: InputFieldModel, delegate: InputFieldViewDelegate? = nil) {
        self.init()
        
        self.model = model
        specificDelegate = delegate
        
        titleView.text = model.title
        textField.text = model.value
        
        configure()
    }
    
    // MARK: - Public Functions
    
    func setContentType(_ type: UITextContentType) {
        textField.textContentType = type
    }
    
    func setKeyboardType(_ type: UIKeyboardType) {
        textField.keyboardType = type
    }
    
    // MARK: - Private Functions
    
    func configure() {
        textField.delegate = self
        
        let selector = #selector(textDidChange)
        textField.addTarget(self, action: selector, for: .editingChanged)
    }
    
    @objc private func textDidChange() {
        textField.backgroundColor = isCorrectValue == false ? UIColor.red.withAlphaComponent(0.1) : .clear
        specificDelegate?.valueDidChange(self)
    }
    
}

// MARK: - Text Field Delegate

extension InputFieldView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let model = model else {
            return false
        }
        
        guard let stringRange = Range(range, in: text) else {
            return false
        }
        
        let updatedText = text.replacingCharacters(in: stringRange, with: string)
        
        if updatedText.count > model.maxLenght {
            return false
        }
        
        model.value = updatedText
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // did press return
        return false
    }
    
}
