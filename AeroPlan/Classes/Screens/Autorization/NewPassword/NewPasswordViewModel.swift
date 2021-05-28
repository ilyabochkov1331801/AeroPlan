//
//  NewPasswordViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

final class NewPasswordViewModel: ViewModel {
    struct Transitions: ScreenTransitions {
        var openSignIn: ScreenTransition?
        var openPrivacy: ScreenTransition?
    }
    
    var transitions = Transitions()
    
    var errorOccurred: ((AppError) -> Void)?
    var activity: ((Bool) -> Void)?
}
