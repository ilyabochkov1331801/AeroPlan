//
//  LaunchViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import RxSwift
import RxCocoa

final class LaunchViewModel: ViewModel {
    struct Transitions: ScreenTransitions {
        var openHomeFlow: ScreenTransition?
        var openAutorizationFlow: ScreenTransition?
    }
    
    private let errorSubject = PublishRelay<AppError>()
        
    var transitions = Transitions()
    
    var activity: ((Bool) -> Void)?
    var errorObservable: Observable<AppError> {
        errorSubject.asObservable()
    }
    
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
        activity?(true)
        guard autorizationInteractor.storedUser == nil else {
            completion(false)
            activity?(false)
            return
        }
        
        autorizationInteractor.registerAnonimous { [weak self] result in
            self?.activity?(false)
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                self?.errorSubject.accept(error)
            }
        }
    }
}
