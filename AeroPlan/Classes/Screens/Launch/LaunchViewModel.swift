//
//  LaunchViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

final class LaunchViewModel: ViewModel {
    struct Transitions: ScreenTransitions {
        var openHomeFlow: ScreenTransition?
        var openAutorizationFlow: ScreenTransition?
    }
    
    var transitions = Transitions()
}
