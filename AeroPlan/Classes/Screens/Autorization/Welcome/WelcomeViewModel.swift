//
//  WelcomeViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import Foundation

class WelcomeViewModel: ViewModel {
    struct Transitions: ScreenTransitions {
        var openHomeFlow: ScreenTransition?
        var openSignIn: ScreenTransition?
        var openPrivacy: ScreenTransition?
    }
    
    var errorOccurred: ((AppError) -> Void)?
    var transitions = Transitions()
}

extension WelcomeViewModel {
    func termsOfConditionsTapped() {
        transitions.openPrivacy?()
    }
    
    @objc func startAdventureTapped() {
        transitions.openHomeFlow?()
    }
    
    @objc func signInTapped() {
        transitions.openSignIn?()
    }
}

extension WelcomeViewModel {
    var signInButtonText: NSAttributedString {
        R.string.localizable.welcomeScreenSignUp()
            .attributeString(with: AppFonts.WelcomeScreen.signInButtonTitle, color: AppColors.WelcomeScreen.signInButtonTitle)
    }
}
