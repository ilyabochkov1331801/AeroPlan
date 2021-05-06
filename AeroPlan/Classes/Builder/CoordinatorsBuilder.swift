//
//  CoordinatorsBuilder.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.04.21.
//

final class CoordinatorsBuilder {
    static func makeRootCoordinator() -> RootCoordinator {
        RootCoordinator(parent: nil)
    }
    
    static func makeAutorizationCoordinator(parent: Coordinator?,
                                            homeFlowTransition: @escaping () -> Void) -> AutorizationCoordinator {
        AutorizationCoordinator(parent: parent, homeFlowTransition: homeFlowTransition)
    }
    
    static func makeHomeCoordinator(parent: Coordinator?) -> HomeCoordinator {
        HomeCoordinator(parent: parent)
    }
}
