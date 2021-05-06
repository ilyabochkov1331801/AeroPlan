//
//  ScreensBuilder.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import UIKit

final class ScreensBuilder {
    static func makeLaunchScreen(resolver: DependencyResolver) -> LaunchScreen {
        let viewModel = LaunchViewModel()
        return LaunchScreen(viewModel: viewModel)
    }
    
    static func makeWelcomeScreen(resolver: DependencyResolver) -> WelcomeScreen {
        let viewModel = WelcomeViewModel()
        return WelcomeScreen(viewModel: viewModel)
    }
    
    static func makeSignInScreen(resolver: DependencyResolver) -> SignInScreen {
        let viewModel = SignInViewModel()
        return SignInScreen(viewModel: viewModel)
    }
    
    static func makeCreateAccountScreen(resolver: DependencyResolver) -> CreateAccountScreen {
        let viewModel = CreateAccountViewModel()
        return CreateAccountScreen(viewModel: viewModel)
    }
    
    static func makeResetPasswordScreen(resolver: DependencyResolver) -> ResetPasswordScreen {
        let viewModel = ResetPasswordViewModel()
        return ResetPasswordScreen(viewModel: viewModel)
    }
    
    static func makeNewPasswordScreen(resolver: DependencyResolver) -> NewPasswordScreen {
        let viewModel = NewPasswordViewModel()
        return NewPasswordScreen(viewModel: viewModel)
    }
}
