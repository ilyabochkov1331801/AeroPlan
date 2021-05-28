//
//  SignInViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import GoogleSignIn

final class SignInViewModel: NSObject, ViewModel {
    struct Transitions: ScreenTransitions {
        var openHomeFlow: ScreenTransition?
        var openCreateAccount: ScreenTransition?
        var openResetPassword: ScreenTransition?
    }
        
    var transitions = Transitions()
    
    var errorOccurred: ((AppError) -> Void)?
    var activity: ((Bool) -> Void)?
    
    private let autorizationInteractor: AutorizationInteractor
    
    init(autorizationInteractor: AutorizationInteractor) {
        self.autorizationInteractor = autorizationInteractor
    }
}

extension SignInViewModel {
    func signInWith(username: String, password: String) {
        activity?(true)
        guard isUsernameTextValid(username) else {
            self.errorOccurred?(AutorizationError(comment: "Invalid username"))
            activity?(false)
            return
        }
        
        guard isPasswordTextValid(password) else {
            self.errorOccurred?(AutorizationError(comment: "Invalid password"))
            activity?(false)
            return
        }
        
        autorizationInteractor.signInWith(name: username, password: password) { [weak self] result in
            self?.activity?(false)
            switch result {
            case .success:
                self?.transitions.openHomeFlow?()
            case .failure(let error):
                self?.errorOccurred?(AutorizationError(previousAppError: error))
            }
        }
    }
    
    func isUsernameTextValid(_ text: String) -> Bool {
        text.isValidUsername
    }
    
    func isPasswordTextValid(_ text: String) -> Bool {
        text.isValidPassword
    }
    
    @objc func forgotPasswordButtonTapped() {
        transitions.openResetPassword?()
    }
    
    @objc func createAccountButtonTapped() {
        transitions.openCreateAccount?()
    }
    
    @objc func logInWithGoogleButtonTapped() {
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
            errorOccurred?(AutorizationError(previousError: error))
        }
        
        guard let userId = user?.userID else {
            errorOccurred?(AutorizationError(comment: "No user id"))
            return
        }
        
        autorizationInteractor.signInWith(googleId: userId) { [weak self] result in
            switch result {
            case .success:
                self?.transitions.openHomeFlow?()
            case .failure(let error):
                self?.errorOccurred?(AutorizationError(previousAppError: error))
            }
        }
    }
}
