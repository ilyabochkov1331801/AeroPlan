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
    
    private let autorizationInteractor: AutorizationInteractor
    
    init(autorizationInteractor: AutorizationInteractor) {
        self.autorizationInteractor = autorizationInteractor
    }
    
    func launchApplication() {
        checkAutorization { isNewAnonUserRegistered in
            isNewAnonUserRegistered
                ? self.transitions.openAutorizationFlow?()
                : self.transitions.openHomeFlow?()
        }
    }
}

private extension LaunchViewModel {
    func checkAutorization(completion: @escaping (Bool) -> Void) {
        guard autorizationInteractor.storedUser == nil else {
            completion(false)
            return
        }
        
        autorizationInteractor.registerAnonimus { [weak self] result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                self?.errorOccurred?(error)
            }
        }
    }
}
