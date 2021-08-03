//
//  LaunchViewModel.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import RxCocoa
import RxSwift

final class LaunchViewModel: ViewModel {
    struct Transitions: ScreenTransitions {
        var openHomeFlow: ScreenTransition?
        var openAutorizationFlow: ScreenTransition?
    }
            
    var transitions = Transitions()
        
    private let activitySubject = PublishRelay<Bool>()
    private let autorizationInteractor: AuthorizationInteractor
    
    var activity: Driver<Bool> {
        activitySubject
            .asDriver(onErrorJustReturn: false)
    }
    
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
                self?.showError(error)
            }
        }
    }
}
