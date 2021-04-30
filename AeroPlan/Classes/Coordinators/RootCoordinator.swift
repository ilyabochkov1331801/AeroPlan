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
    
    func start(at window: UIWindow?) {
        assert(window != nil, "Root Window is nil")
        window?.rootViewController = baseViewController
        showLaunchScreen()
        window?.makeKeyAndVisible()
    }
}

private extension RootCoordinator {
    func showLaunchScreen() {
        let screen = ScreensBuilder.makeLaunchScreen(resolver: self)
        
        screen.transitions.openHomeFlow = { [weak self] in self?.showHomeFlow() }
        screen.transitions.openAutorizationFlow = { [weak self] in self?.showAutorizationFlow() }

        setContentCoordinator(nil)
        containerViewController.setContentViewController(screen)
    }
    
    func showHomeFlow() {
        let homeCoordinator = CoordinatorsBuilder.makeHomeCoordinator(parent: self)
        setContentCoordinator(homeCoordinator, animator: transitionAnimator)
    }
    
    func showAutorizationFlow() {
        let autorizationCoordinator = CoordinatorsBuilder.makeAutorizationCoordinator(parent: self) { [weak self] in
            self?.showHomeFlow()
        }
        
        setContentCoordinator(autorizationCoordinator, animator: transitionAnimator)
    }
}
