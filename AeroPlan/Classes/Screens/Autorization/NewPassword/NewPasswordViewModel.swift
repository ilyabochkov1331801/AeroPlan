//
//  NewPasswordViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import Foundation
import RxSwift
import RxCocoa

final class NewPasswordViewModel: NSObject, ViewModel {
    struct Transitions: ScreenTransitions {
        var openSignIn: ScreenTransition?
        var openPrivacy: ScreenTransition?
    }
    
    private let errorSubject = PublishRelay<AppError>()
    
    var transitions = Transitions()
    
    var errorObservable: Observable<AppError> {
        errorSubject.asObservable()
    }
    var activity: ((Bool) -> Void)?
    
    private let authorizationInteractor: AuthorizationInteractor
    
    init(authorizationInteractor: AuthorizationInteractor) {
        self.authorizationInteractor = authorizationInteractor
    }
}

extension NewPasswordViewModel {
    func changePassword(password: String) {
        activity?(true)
        guard isPasswordValid(password) else {
            errorSubject.accept(AuthorizationError(comment: "Invalid password"))
            activity?(false)
            return
        }
        
        authorizationInteractor.changePassword(password: password) { [weak self] result in
            self?.activity?(false)
            switch result {
            case .success:
                break
            case .failure(let error):
                self?.errorSubject.accept(AuthorizationError(previousAppError: error))
            }
        }
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        password.isValidPassword
    }
}

extension NewPasswordViewModel {
    private typealias Fonts = AppFonts.NewPasswordScreen
    private typealias Colors = AppColors.NewPasswordScreen
    
    var appTitleText: NSAttributedString {
        R.string.localizable.appTitle()
            .attributeString(with: Fonts.appTitle, color: AppColors.Common.appTitle, alignment: .center)
            .attribute(text: R.string.localizable.appTitleHighlighted(), with: .make(font: Fonts.appTitle))
    }
    
    var passwordPlaceholder: NSAttributedString {
        R.string.localizable.resetPasswordScreenEmail()
            .attributeString(with: Fonts.password, color: Colors.passwordPlaceholder)
    }
    
    var changePasswordText: NSAttributedString {
        R.string.localizable.resetPasswordScreenResetPassword()
            .attributeString(with: Fonts.changePassword, color: Colors.changePasswordTitle)
    }
}
