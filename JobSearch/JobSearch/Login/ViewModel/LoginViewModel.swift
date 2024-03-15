//
//  LoginViewModel.swift
//  JobSearch
//
//  Created by User on 13.03.2024.
//

import UIKit


protocol LoginViewModelProtocol {
    associatedtype T
    
    var buttonColor: Dynamic<T> { get set }
    var textColor: Dynamic<T> { get set }
    var descriptionText: Dynamic<T> { get set }
    
    func buttonPressed(email: String?)
}

final class LoginViewModel: LoginViewModelProtocol {
    // MARK: - Properties
    typealias T = UIColor
    
    private let validEmail = "^([a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]){3,64}@[a-zA-Z0-9])\\.[a-z]{1,3}$"
    
    var buttonColor = Dynamic(UIColor.white)
    var textColor = Dynamic(UIColor.white)
    var descriptionText: Dynamic(String)
    
    func buttonPressed(email: String?) {
        guard let email else { return }
        if email.matches(validEmail) {
// PUSH VC
        } else {
            
        }
    }
}
