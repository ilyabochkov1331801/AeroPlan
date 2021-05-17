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
        var openPrivacy: ScreenTransition?
    }
        
    var transitions = Transitions()
    var errorOccurred: ((AppError) -> Void)?
    
    private let autorizationInteractor: AutorizationInteractor
    
    init(autorizationInteractor: AutorizationInteractor) {
        self.autorizationInteractor = autorizationInteractor
    }
}

extension SignInViewModel {
    func signInWith(username: String, password: String) {
        guard isUsernameTextValid(username) else {
            self.errorOccurred?(AutorizationError(comment: "Invalid username"))
            return
        }
        
        guard isPasswordTextValid(password) else {
            self.errorOccurred?(AutorizationError(comment: "Invalid password"))
            return
        }
        
        autorizationInteractor.signInWith(name: username, password: password) { [weak self] result in
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
    
    func termsOfConditionsTapped() {
        transitions.openPrivacy?()
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
