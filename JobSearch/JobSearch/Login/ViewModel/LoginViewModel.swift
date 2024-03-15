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
}

final class LoginViewModel: LoginViewModelProtocol {
    // MARK: - Properties
    private let validEmail = #"^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~]{1,64}@[a-zA-Z0-9]+\.[a-z]{2,3}$"#
    
    var email = ""
    var buttonColor = Dynamic(UIColor.darkBlue)
    var textColor = Dynamic(UIColor.gray4)
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
            textColor.value = UIColor.gray4
        }
    }
    
    func checkCode() {
        
    }
}
