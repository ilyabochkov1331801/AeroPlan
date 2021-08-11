//
//  NewPasswordViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import RxCocoa
import RxSwift

struct NewPasswordTransitions: ScreenTransitions {
    var openSignIn: ScreenTransition?
    var openPrivacy: ScreenTransition?
}

final class NewPasswordViewModel: ViewModel<NewPasswordTransitions> {
    private let autorizationInteractor: AuthorizationInteractor
    
    init(autorizationInteractor: AuthorizationInteractor) {
        self.autorizationInteractor = autorizationInteractor
    }
}

extension NewPasswordViewModel {
    func changePassword(password: String) {
        activitySubject.accept(true)
        guard isPasswordValid(password) else {
            error.onNext(AuthorizationError(comment: "Invalid password"))
            activitySubject.accept(false)
            return
        }
        
        autorizationInteractor.changePassword(password: password) { [weak self] result in
            self?.activitySubject.accept(false)
            switch result {
            case .success:
                break
            case .failure(let error):
                self?.error.onNext(AuthorizationError(previousAppError: error))
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
