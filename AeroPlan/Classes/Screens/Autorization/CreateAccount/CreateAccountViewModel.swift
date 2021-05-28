//
//  CreateAccountViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import Foundation

final class CreateAccountViewModel: ViewModel {
    struct Transitions: ScreenTransitions {
        var openHomeFlow: ScreenTransition?
        var openSignIn: ScreenTransition?
        var openPrivacy: ScreenTransition?
    }
    
    var errorOccurred: ((AppError) -> Void)?
    var activity: ((Bool) -> Void)?
    
    var transitions = Transitions()
    
    private let autorizationInteractor: AutorizationInteractor
    
    init(autorizationInteractor: AutorizationInteractor) {
        self.autorizationInteractor = autorizationInteractor
    }
}

extension CreateAccountViewModel {
    func createAccount(name: String, email: String, password: String) {
        activity?(true)
        
        guard name.isValidUsername else {
            self.errorOccurred?(AutorizationError(comment: "Invalid username"))
            activity?(false)
            return
        }
        
        guard email.isValidEmail else {
            self.errorOccurred?(AutorizationError(comment: "Invalid email"))
            activity?(false)
            return
        }
        
        guard password.isValidPassword else {
            self.errorOccurred?(AutorizationError(comment: "Invalid password"))
            activity?(false)
            return
        }
        
        autorizationInteractor.createAccount(name: name, email: email, password: password) { [weak self] result in
            self?.activity?(false)
            switch result {
            case .success:
                self?.transitions.openHomeFlow?()
            case .failure(let error):
                self?.errorOccurred?(error)
            }
        }
    }
    
    func isUsernameTextValid(_ text: String) -> Bool {
        text.isValidUsername
    }
    
    func isPasswordTextValid(_ text: String) -> Bool {
        text.isValidPassword
    }
    
    func isEmailTextValid(_ text: String) -> Bool {
        text.isValidEmail
    }
    
    @objc func signInButtonTapped() {
        transitions.openSignIn?()
    }
    
    func termsOfConditionsTapped() {
        transitions.openPrivacy?()
    }
}

extension CreateAccountViewModel {
    private typealias Fonts = AppFonts.CreateAccountScreen
    private typealias Colors = AppColors.CreateAccountScreen
    
    var createAccountText: NSAttributedString {
        R.string.localizable.createAccountCreateAccount()
            .attributeString(with: Fonts.createAccount, color: Colors.createAccountTitle)
    }
    
    var alreadyRegisteredText: NSAttributedString {
        R.string.localizable.createAccountAlreadyRegistered()
            .attributeString(with: Fonts.alreadyRegistered, color: Colors.alreadyRegistered)
    }
    
    var signInText: NSAttributedString {
        R.string.localizable.createAccountSignIn()
            .attributeString(with: Fonts.signIn, color: Colors.signIn)
    }
    
    var titleText: NSAttributedString {
        R.string.localizable.appTitle()
            .attributeString(with: AppFonts.Common.appTitle.normal, color: AppColors.Common.appTitle, alignment: .center)
            .attribute(text: R.string.localizable.appTitleHighlighted(), with: .make(font: AppFonts.Common.appTitle.highlighted))
    }
    
    var usernamePlaceholder: String {
        R.string.localizable.createAccountUsernamePlaceholder()
    }
    
    var passwordPlaceholder: String {
        R.string.localizable.createAccountPasswordPlaceholder()
    }
    
    var emailPlaceholder: String {
        R.string.localizable.createAccountEmailPlaceholder()
    }
}
