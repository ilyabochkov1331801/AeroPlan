//
//  AutorizationInteractor.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 8.05.21.
//

import Foundation

final class AutorizationInteractor {
    private let apiDataManager: APIDataManager
    private let storageDataManager: StorageDataManger
    
    init(apiDataManager: APIDataManager,
         storageDataManager: StorageDataManger) {
        self.apiDataManager = apiDataManager
        self.storageDataManager = storageDataManager
    }
    
    var storedUser: User? {
        storageDataManager.get(key: .user)
    }
    
    func registerAnonimus(completion: @escaping (Result<Void, AutorizationError>) -> Void) {
        apiDataManager.execute(request: .registerAnon()) { [weak self] result in
            switch result {
            case .success(let user):
                self?.storageDataManager.save(object: user, key: .user)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(AutorizationError(previousAppError: error)))
            }
        }
    }
}

private extension APIRequest {
    static func registerAnon() -> APIRequest<User> {
        .make(path: "/register/anonymous", method: .post, needsAuthorization: false, queryItems: nil, parameters: nil)
    }
}
