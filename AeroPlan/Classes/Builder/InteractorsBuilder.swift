//
//  InteractorsBuilder.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 8.05.21.
//

import Foundation

final class InteractorsBuilder {
    static func makeAutorizationInteractor(resolver: DependencyResolver) -> AutorizationInteractor {
        AutorizationInteractor(apiDataManager: DataManagersBuilder.makeAPIDataManager(),
                               storageDataManager: DataManagersBuilder.makeStorageDataManager())
    }
}
