//
//  CreateAccountViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import RxCocoa
import RxSwift

struct CreateAccountTransitions: ScreenTransitions {
    var openHomeFlow: ScreenTransition?
    var openSignIn: ScreenTransition?
    var openPrivacy: ScreenTransition?
}

final class CreateAccountViewModel: ViewModel<CreateAccountTransitions> {
    private let autorizationInteractor: AuthorizationInteractor

    init(autorizationInteractor: AuthorizationInteractor) {
        self.autorizationInteractor = autorizationInteractor
    }
}

extension CreateAccountViewModel {
    func createAccount(name: String, email: String, password: String) {
        activitySubject.accept(true)
        
        guard name.isValidUsername else {
            error.onNext(AuthorizationError(comment: "Invalid username"))
            activitySubject.accept(false)
            return
        }
        
        guard email.isValidEmail else {
            error.onNext(AuthorizationError(comment: "Invalid email"))
            activitySubject.accept(false)
            return
        }
        
        guard password.isValidPassword else {
            error.onNext(AuthorizationError(comment: "Invalid password"))
            activitySubject.accept(false)
            return
        }
        
        autorizationInteractor.createAccount(name: name, email: email, password: password) { [weak self] result in
            self?.activitySubject.accept(false)
            switch result {
            case .success:
                self?.transitions.openHomeFlow?()
            case .failure(let error):
                self?.error.onNext(error)
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
    
    func signInButtonTapped() {
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
