//
//  InputFieldViewFactory.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 11.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

final class InputFieldViewFactory {
    
    func createNameInputField(title: String, value: String? = nil, delegate: InputFieldViewDelegate? = nil) -> InputFieldView {
        let maxLenght = 64
        let validationRules = "([a-zA-Zа-яА-Я])\\w{3,\(maxLenght)}"
        
        let model = InputFieldModel(title: title, validationRules: validationRules, maxLenght: maxLenght, value: value)
        let inputFieldView = InputFieldView(model: model, delegate: delegate)
        
        inputFieldView.setContentType(.name)
        inputFieldView.setKeyboardType(.default)
        
        return inputFieldView
    }
    
    func createEmailInputField(value: String? = nil, delegate: InputFieldViewDelegate? = nil) -> InputFieldView {
        let title = "Электронная почта"
        let maxLenght = 64
        
        let validationRules = "[А-ЯA-Z0-9a-zа-я._%+-]+@[А-ЯA-Za-zа-я0-9.-]+\\.[А-ЯA-Za-zа-я]{2,\(maxLenght)}"
        
        let model = InputFieldModel(title: title, validationRules: validationRules, maxLenght: maxLenght, value: value)
        let inputFieldView = InputFieldView(model: model, delegate: delegate)
        
        inputFieldView.setContentType(.emailAddress)
        inputFieldView.setKeyboardType(.emailAddress)
        
        return inputFieldView
    }
    
    func createPhoneInputField(value: String? = nil, delegate: InputFieldViewDelegate? = nil) -> InputFieldView {
        let title = "Номер телефона"
        let maxLenght = 10
        
        let validationRules = "[0-9]{\(maxLenght)}"
        
        let model = InputFieldModel(title: title, validationRules: validationRules, maxLenght: maxLenght, value: value)
        let inputFieldView = PhoneInputFieldView(model: model, delegate: delegate)
        
        inputFieldView.setContentType(.telephoneNumber)
        inputFieldView.setKeyboardType(.numberPad)
        
        return inputFieldView
    }
    
}
