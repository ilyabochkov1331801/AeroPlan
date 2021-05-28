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
    
    var errorOccurred: ((AppError) -> Void)?
    var activity: ((Bool) -> Void)?
    
    private let autorizationInteractor: AutorizationInteractor
    
    init(autorizationInteractor: AutorizationInteractor) {
        self.autorizationInteractor = autorizationInteractor
    }
    
    func launchApplication() {
//        checkAutorization { isNewAnonUserRegistered in
//            isNewAnonUserRegistered
//                ? self.transitions.openAutorizationFlow?()
//                : self.transitions.openHomeFlow?()
//        }
        transitions.openAutorizationFlow?()
    }
}

private extension LaunchViewModel {
    func checkAutorization(completion: @escaping (Bool) -> Void) {
        activity?(true)
        guard autorizationInteractor.storedUser == nil else {
            completion(false)
            activity?(false)
            return
        }
        
        autorizationInteractor.registerAnonimus { [weak self] result in
            self?.activity?(false)
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                self?.errorOccurred?(error)
            }
        }
    }
}
