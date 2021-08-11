//
//  LaunchViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import RxCocoa
import RxSwift

struct LaunchTransitions: ScreenTransitions {
    var openHomeFlow: ScreenTransition?
    var openAutorizationFlow: ScreenTransition?
}

final class LaunchViewModel: ViewModel<LaunchTransitions> {
    private let autorizationInteractor: AuthorizationInteractor
    
    init(autorizationInteractor: AuthorizationInteractor) {
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
        activitySubject.accept(true)
        guard autorizationInteractor.storedUser == nil else {
            completion(false)
            activitySubject.accept(false)
            return
        }
        
        autorizationInteractor.registerAnonimous { [weak self] result in
            self?.activitySubject.accept(false)
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                self?.error.onNext(error)
            }
        }
    }
}
