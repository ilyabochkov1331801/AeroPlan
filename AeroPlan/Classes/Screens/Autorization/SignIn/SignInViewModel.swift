//
//  SignInViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import GoogleSignIn
import RxCocoa
import RxSwift

struct SignInTransitions: ScreenTransitions {
    var openHomeFlow: ScreenTransition?
    var openCreateAccount: ScreenTransition?
    var openResetPassword: ScreenTransition?
}

final class SignInViewModel: ViewModel<SignInTransitions> {
    private let authorizationInteractor: AuthorizationInteractor
    let googleAutorizationHandler: GoogleAutorizationHandler
    
    init(authorizationInteractor: AuthorizationInteractor) {
        self.authorizationInteractor = authorizationInteractor
        self.googleAutorizationHandler = GoogleAutorizationHandler()
        
        super.init()
        
        googleAutorizationHandler.sign = sign
    }
}

extension SignInViewModel {
    func signInWith(username: String, password: String) {
        activitySubject.accept(true)
        guard isUsernameTextValid(username) else {
            error.onNext(AuthorizationError(comment: "Invalid username"))
            activitySubject.accept(false)
            return
        }
        
        guard isPasswordTextValid(password) else {
            error.onNext(AuthorizationError(comment: "Invalid password"))
            activitySubject.accept(false)
            return
        }
        
        authorizationInteractor.signInWith(name: username, password: password) { [weak self] result in
            self?.activitySubject.accept(false)
            switch result {
            case .success:
                self?.transitions.openHomeFlow?()
            case .failure(let error):
                self?.error.onNext(AuthorizationError(previousAppError: error))
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

extension SignInViewModel {
    class GoogleAutorizationHandler: NSObject, GIDSignInDelegate {
        var sign: ((GIDSignIn, GIDGoogleUser, Error) -> Void)?
        
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            sign?(signIn, user, error)
        }
    }
}

private extension SignInViewModel {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            self.error.onNext(AuthorizationError(previousError: error))
        }
        
        guard let userId = user?.userID else {
            self.error.onNext(AuthorizationError(comment: "No user id"))
            return
        }
        
        authorizationInteractor.signInWith(googleId: userId) { [weak self] result in
            switch result {
            case .success:
                self?.transitions.openHomeFlow?()
            case .failure(let error):
                self?.error.onNext(AuthorizationError(previousAppError: error))
            }
        }
    }
}
