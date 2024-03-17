//
//  LoginViewModel.swift
//  JobSearch
//
//  Created by User on 13.03.2024.
//

import UIKit

protocol LoginViewModelProtocol {
    var buttonColor: Dynamic<UIColor> { get set }
    var textColor: Dynamic<UIColor> { get set }
    var borderColor: Dynamic<UIColor> { get set }
    var descriptionText: Dynamic<String> { get set }
    var email: String { get set }
    
    func buttonPressed(email: String?) -> Bool
    func textDidChange(text: String, button: UIButton)
    func changeColorAndCheckFullness(textFields: [UITextField], button: UIButton) -> Bool
}

final class LoginViewModel: LoginViewModelProtocol {
    // MARK: - Properties
    private let validEmail = #"^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~]{1,64}@[a-zA-Z0-9]+\.[a-z]{2,3}$"#
    
    var email = ""
    var buttonColor = Dynamic(UIColor.darkBlue)
    var textColor = Dynamic(UIColor.grey4)
    var descriptionText = Dynamic("")
    var borderColor = Dynamic(UIColor.clear)
    
    func buttonPressed(email: String?) -> Bool {
        guard let email else { return false }
        if email.matches(validEmail) {
            return true
        } else {
            descriptionText.value = "Вы ввели неверный e-mail"
            borderColor.value = UIColor.red
            return false
        }
    }
    
    // MARK: - Methods
    func textDidChange(text: String, button: UIButton) {
        if !text.isEmpty {
            buttonColor.value = UIColor.systemBlue
            textColor.value = UIColor.white
            descriptionText.value = ""
            borderColor.value = UIColor.clear
            button.isUserInteractionEnabled = true
            email = text
        } else {
            button.isUserInteractionEnabled = false
            buttonColor.value = UIColor.darkBlue
            textColor.value = UIColor.grey4
        }
    }
    
    func changeColorAndCheckFullness(textFields: [UITextField], button: UIButton) -> Bool {
        for textField in textFields {
            guard let text = textField.text,
                  !text.isEmpty else { return false }
        }
        buttonColor.value = UIColor.systemBlue
        textColor.value = UIColor.white
        
        button.isUserInteractionEnabled = true
        return true
    }
}
