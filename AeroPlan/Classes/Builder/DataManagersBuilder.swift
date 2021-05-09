//
//  DataManagersBuilder.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 8.05.21.
//

import Foundation

final class DataManagersBuilder {
    static func makeAPIDataManager() -> APIDataManager {
        APIDataManager(userProvider: makeStorageDataManager())
    }
    
    static func makeStorageDataManager() -> StorageDataManger {
        StorageDataManger(service: Configuration.global.bundleId)
    }
}
