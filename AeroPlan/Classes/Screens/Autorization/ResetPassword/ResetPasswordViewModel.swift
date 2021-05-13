//
//  ResetPasswordViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

final class ResetPasswordViewModel: ViewModel {
    struct Transitions: ScreenTransitions {
        var openSignIn: ScreenTransition?
        var openPrivacy: ScreenTransition?
    }
    
    var errorOccurred: ((AppError) -> Void)?
    var transitions = Transitions()
}
