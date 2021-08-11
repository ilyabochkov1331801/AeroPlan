//
//  ResetPasswordViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import RxCocoa
import RxSwift

struct ResetPasswordTransitions: ScreenTransitions {
    var openSignIn: ScreenTransition?
    var openPrivacy: ScreenTransition?
}

final class ResetPasswordViewModel: ViewModel<ResetPasswordTransitions> {
    private let autorizationInteractor: AuthorizationInteractor
    
    init(autorizationInteractor: AuthorizationInteractor) {
        self.autorizationInteractor = autorizationInteractor
    }
}

extension ResetPasswordViewModel {
    func resetPassword(email: String) {
        activitySubject.accept(true)
        guard isEmailValid(email) else {
            activitySubject.accept(false)
            return error.onNext(AuthorizationError(comment: "Invalid email"))
        }
        autorizationInteractor.resetPassword(email: email) { [weak self] result in
            self?.activitySubject.accept(false)
            guard let self = self else {
                return
            }
            
            switch result {
            case .success:
                break
            case let .failure(error):
                self.error.onNext(AuthorizationError(previousError: error))
            }
        }
    }
    
    func isEmailValid(_ email: String) -> Bool {
        email.isValidEmail
    }
}

extension ResetPasswordViewModel {
    private typealias Fonts = AppFonts.ResetPasswordScreen
    private typealias Colors = AppColors.ResetPasswordScreen
    
    var appTitleText: NSAttributedString {
        R.string.localizable.appTitle()
            .attributeString(with: Fonts.appTitle, color: AppColors.Common.appTitle, alignment: .center)
            .attribute(text: R.string.localizable.appTitleHighlighted(), with: .make(font: Fonts.appTitle))
    }
    
    var emailPlaceholder: NSAttributedString {
        R.string.localizable.resetPasswordScreenEmail()
            .attributeString(with: Fonts.email, color: Colors.emailPlaceholder)
    }
    
    var resetPasswordText: NSAttributedString {
        R.string.localizable.resetPasswordScreenResetPassword()
            .attributeString(with: Fonts.resetPassword, color: Colors.resetPasswordTitle)
    }
}
