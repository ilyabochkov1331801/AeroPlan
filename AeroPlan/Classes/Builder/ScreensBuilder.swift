//
//  ScreensBuilder.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import UIKit

final class ScreensBuilder {
    static func makeLaunchScreen(resolver: DependencyResolver) -> LaunchScreen {
        let viewModel = LaunchViewModel(autorizationInteractor: InteractorsBuilder.makeAutorizationInteractor(resolver: resolver))
        return LaunchScreen(viewModel: viewModel)
    }
    
    static func makeWelcomeScreen(resolver: DependencyResolver) -> WelcomeScreen {
        let viewModel = WelcomeViewModel()
        return WelcomeScreen(viewModel: viewModel)
    }
    
    static func makeSignInScreen(resolver: DependencyResolver) -> SignInScreen {
        let viewModel = SignInViewModel(authorizationInteractor: InteractorsBuilder.makeAutorizationInteractor(resolver: resolver))
        return SignInScreen(viewModel: viewModel)
    }
    
    static func makeCreateAccountScreen(resolver: DependencyResolver) -> CreateAccountScreen {
        let viewModel = CreateAccountViewModel(autorizationInteractor: InteractorsBuilder.makeAutorizationInteractor(resolver: resolver))
        return CreateAccountScreen(viewModel: viewModel)
    }
    
    static func makeResetPasswordScreen(resolver: DependencyResolver) -> ResetPasswordScreen {
        let viewModel = ResetPasswordViewModel(authorizationInteractor: InteractorsBuilder.makeAutorizationInteractor(resolver: resolver))
        return ResetPasswordScreen(viewModel: viewModel)
    }
    
    static func makeNewPasswordScreen(resolver: DependencyResolver) -> NewPasswordScreen {
        let viewModel = NewPasswordViewModel()
        return NewPasswordScreen(viewModel: viewModel)
    }
}
