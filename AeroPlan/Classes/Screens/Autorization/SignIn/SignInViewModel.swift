//
//  SignInViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import GoogleSignIn
import RxCocoa
import RxSwift

final class SignInViewModel: NSObject, ViewModel {
    struct Transitions: ScreenTransitions {
        var openHomeFlow: ScreenTransition?
        var openCreateAccount: ScreenTransition?
        var openResetPassword: ScreenTransition?
    }
    
    var transitions = Transitions()
    
    private let activitySubject = PublishRelay<Bool>()
    private let authorizationInteractor: AuthorizationInteractor
    
    var activity: Driver<Bool> {
        activitySubject
            .asDriver(onErrorJustReturn: false)
    }
    
    init(authorizationInteractor: AuthorizationInteractor) {
        self.authorizationInteractor = authorizationInteractor
    }
}

extension SignInViewModel {
    func signInWith(username: String, password: String) {
        activitySubject.accept(true)
        guard isUsernameTextValid(username) else {
            showError(AuthorizationError(comment: "Invalid username"))
            activitySubject.accept(false)
            return
        }
        
        guard isPasswordTextValid(password) else {
            showError(AuthorizationError(comment: "Invalid password"))
            activitySubject.accept(false)
            return
        }
        
        authorizationInteractor.signInWith(name: username, password: password) { [weak self] result in
            self?.activitySubject.accept(false)
            switch result {
            case .success:
                self?.transitions.openHomeFlow?()
            case .failure(let error):
                self?.showError(AuthorizationError(previousAppError: error))
            }
        }
    }
    
    func isUsernameTextValid(_ text: String) -> Bool {
        text.isValidUsername
    }
    
    func isPasswordTextValid(_ text: String) -> Bool {
        text.isValidPassword
    }
    
    func forgotPasswordButtonTapped() {
        transitions.openResetPassword?()
    }
    
    func createAccountButtonTapped() {
        transitions.openCreateAccount?()
    }
    
    func logInWithGoogleButtonTapped() {
        GIDSignIn.sharedInstance().signIn()
    }
}

extension SignInViewModel {
    private typealias Fonts = AppFonts.SignInScreen
    private typealias Colors = AppColors.SignInScreen
    
    var logInText: NSAttributedString {
        R.string.localizable.signInScreenLogin()
            .attributeString(with: Fonts.logIn, color: Colors.logInTitle)
    }
    
    var titleText: NSAttributedString {
        R.string.localizable.appTitle()
            .attributeString(with: AppFonts.Common.appTitle.normal, color: AppColors.Common.appTitle, alignment: .center)
            .attribute(text: R.string.localizable.appTitleHighlighted(), with: .make(font: AppFonts.Common.appTitle.highlighted))
    }
    
    var usernamePlaceholder: String {
        R.string.localizable.signInUsernamePlaceholder()
    }
    
    var passwordPlaceholder: String {
        R.string.localizable.signInPasswordPlaceholder()
    }
    
    var forgotPasswordText: NSAttributedString {
        R.string.localizable.signInForgotPassword()
            .attributeString(with: Fonts.forgotPassword, color: Colors.forgotPassword, alignment: .center)
    }
    
    var newUserText: NSAttributedString {
        R.string.localizable.signInNewUser()
            .attributeString(with: Fonts.newUser, color: Colors.newUser)
    }
    
    var createAccountText: NSAttributedString {
        R.string.localizable.signInCreateAccout()
            .attributeString(with: Fonts.createAccount, color: Colors.createAccount)
    }
    
    var separatorImage: UIImage? {
        R.image.icons.horizontalSeparator()
    }
    
    var logInWithGoogleText: NSAttributedString {
        R.string.localizable.signInLogInWithGoogle()
            .attributeString(with: Fonts.logInWithGoogle, color: Colors.logInWithGoogle)
    }
    
    var logInWithGoogleImage: UIImage? {
        R.image.icons.google()
    }
}

extension SignInViewModel: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            showError(AuthorizationError(previousError: error))
        }
        
        guard let userId = user?.userID else {
            showError(AuthorizationError(comment: "No user id"))
            return
        }
        
        authorizationInteractor.signInWith(googleId: userId) { [weak self] result in
            switch result {
            case .success:
                self?.transitions.openHomeFlow?()
            case .failure(let error):
                self?.showError(AuthorizationError(previousAppError: error))
            }
        }
    }
}
