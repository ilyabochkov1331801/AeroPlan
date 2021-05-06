//
//  SignInViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

final class SignInViewModel: ViewModel {
    struct Transitions: ScreenTransitions {
        var openHomeFlow: ScreenTransition?
        var openCreateAccount: ScreenTransition?
        var openResetPassword: ScreenTransition?
        var openPrivacy: ScreenTransition?
    }
    
    var transitions = Transitions()
}
