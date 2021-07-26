//
//  WelcomeViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import UIKit
import RxCocoa
import RxSwift

class WelcomeViewModel: ViewModel {
    struct Transitions: ScreenTransitions {
        var openHomeFlow: ScreenTransition?
        var openSignIn: ScreenTransition?
        var openPrivacy: ScreenTransition?
    }
    
    private let errorSubject = PublishRelay<AppError>()
    
    var transitions = Transitions()
    
    var errorObservable: Observable<AppError> {
        errorSubject.asObservable()
    }
    var activity: ((Bool) -> Void)?
}

extension WelcomeViewModel {
    func termsOfConditionsTapped() {
        transitions.openPrivacy?()
    }
    
    @objc func startAdventureButtonTapped() {
        transitions.openHomeFlow?()
    }
    
    @objc func signInButtonTapped() {
        transitions.openSignIn?()
    }
}

extension WelcomeViewModel {
    private typealias Fonts = AppFonts.WelcomeScreen
    private typealias Colors = AppColors.WelcomeScreen
    
    var signInText: NSAttributedString {
        R.string.localizable.welcomeScreenSignIn()
            .attributeString(with: Fonts.signIn, color: Colors.signIn)
    }
    
    var startAdventureText: NSAttributedString {
        R.string.localizable.welcomeScreenStartAdventure()
            .attributeString(with: Fonts.startAdventure, color: Colors.startAdventureTitle)
    }
    
    var titleText: NSAttributedString {
        R.string.localizable.appTitle()
            .attributeString(with: AppFonts.Common.appTitle.normal, color: AppColors.Common.appTitle, alignment: .center)
            .attribute(text: R.string.localizable.appTitleHighlighted(), with: .make(font: AppFonts.Common.appTitle.highlighted))
    }
    
    var alreadyRegisteredText: NSAttributedString {
        R.string.localizable.welcomeScreenAlreadyRegistered()
            .attributeString(with: Fonts.alreadyRegistered, color: Colors.alreadyRegistered)
    }
    
    var illustrationImage: UIImage? {
        R.image.icons.appLogo()
    }
}
