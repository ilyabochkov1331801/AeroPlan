//
//  ResetPasswordViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import Foundation

final class ResetPasswordViewModel: NSObject, ViewModel {
    struct Transitions: ScreenTransitions {
        var openSignIn: ScreenTransition?
        var openPrivacy: ScreenTransition?
    }
    
    var transitions = Transitions()
    
    var errorOccurred: ((AppError) -> Void)?
    var activity: ((Bool) -> Void)?
    
    private let authorizationInteractor: AuthorizationInteractor
    
    init(authorizationInteractor: AuthorizationInteractor) {
        self.authorizationInteractor = authorizationInteractor
    }
}

extension ResetPasswordViewModel {
    func resetPassword(email: String) {
        activity?(true)
        guard isEmailValid(email) else {
            self.errorOccurred?(AuthorizationError(comment: "Invalid email"))
            activity?(false)
            return
        }
        
        
    }
    
    func isEmailValid(_ email: String) -> Bool {
        email.isValidEmail
    }
}

extension ResetPasswordViewModel {
    private typealias Fonts = AppFonts.ResetPasswordScreen
    private typealias Colors = AppColors.ResetPasswordScreen
    
    var emailPlaceholder: NSAttributedString {
        R.string.localizable.resetPasswordScreenEmail()
            .attributeString(with: Fonts.email, color: Colors.emailPlaceholder)
    }
    
    var resetPasswordText: NSAttributedString {
        R.string.localizable.resetPasswordScreenResetPassword()
            .attributeString(with: Fonts.resetPassword, color: Colors.resetPasswordTitle)
    }
}
