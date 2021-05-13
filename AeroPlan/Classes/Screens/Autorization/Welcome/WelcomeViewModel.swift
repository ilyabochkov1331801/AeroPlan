//
//  WelcomeViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

class WelcomeViewModel: ViewModel {
    struct Transitions: ScreenTransitions {
        var openHomeFlow: ScreenTransition?
        var openSignIn: ScreenTransition?
        var openPrivacy: ScreenTransition?
    }
    
    var errorOccurred: ((AppError) -> Void)?
    var transitions = Transitions()
}
