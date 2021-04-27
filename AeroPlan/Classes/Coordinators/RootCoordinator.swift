//
//  RootCoordinator.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.04.21.
//

import Model

final class RootCoordinator: ContainerCoordinator {
    private let transitionAnimator: UIViewControllerAnimatedTransitioning
    
    var startupService: StartupService!
    
    override init(parent: Coordinator?) {
        transitionAnimator = FadeAnimator()

        super.init(parent: parent)
    }
    
    override func registerContent() {
        startupService = ServicesBuilder.makeStartupService(resolver: self)
    }
    
    // TODO: Implement start flow logic
    func start(at window: UIWindow?) {
        assert(window != nil, "Root Window is nil")
        window?.rootViewController = baseViewController
        window?.makeKeyAndVisible()
    }
}
