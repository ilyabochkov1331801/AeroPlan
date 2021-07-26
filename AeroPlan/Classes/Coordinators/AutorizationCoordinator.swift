//
//  AutorizationCoordinator.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import Model

final class AutorizationCoordinator: NavigationCoordinator {
    private let homeFlowTransition: () -> Void
    
    init(parent: Coordinator?, homeFlowTransition: @escaping () -> Void) {
        self.homeFlowTransition = homeFlowTransition
        
        super.init(parent: parent)
        
        configureNavigation()
        showWelcomeScreen()
    }
}

private extension AutorizationCoordinator {
    func configureNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.setBackIndicatorImage(R.image.icons.backArrow(), transitionMaskImage: R.image.icons.backArrow())
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func showWelcomeScreen() {
        let screen = ScreensBuilder.makeWelcomeScreen(resolver: self)
        
        screen.transitions.openHomeFlow = homeFlowTransition
        screen.transitions.openSignIn = { [weak self] in self?.showSignInScreen() }
        screen.transitions.openPrivacy = { print("Privacy opened") }
        
        pushViewController(screen, animated: false)
    }
    
    func showSignInScreen() {
        let screen = ScreensBuilder.makeSignInScreen(resolver: self)
        
        screen.transitions.openHomeFlow = homeFlowTransition
        screen.transitions.openResetPassword = { [weak self] in self?.showResetPasswordScreen() }
        screen.transitions.openCreateAccount = { [weak self] in self?.showCreateAccountScreen() }
        
        pushViewController(screen)
    }
    
    func showCreateAccountScreen() {
        let screen = ScreensBuilder.makeCreateAccountScreen(resolver: self)
        
        screen.transitions.openHomeFlow = homeFlowTransition
        screen.transitions.openSignIn = { [weak self] in self?.popViewController(animated: true) }
        screen.transitions.openPrivacy = { print("Privacy opened") }
        
        pushViewController(screen)
    }
    
    func showResetPasswordScreen() {
        let screen = ScreensBuilder.makeResetPasswordScreen(resolver: self)
        
        screen.transitions.openSignIn = { [weak self] in self?.popViewController(animated: true) }
        screen.transitions.openPrivacy = { print("Privacy opened") }
        
        pushViewController(screen)
    }
    
    func showNewPasswordScreen() {
        let screen = ScreensBuilder.makeNewPasswordScreen(resolver: self)
        
        screen.transitions.openSignIn = { [weak self] in self?.popViewController(animated: true) }
        screen.transitions.openPrivacy = { print("Privacy opened") }
        
        pushViewController(screen)
    }
}
