//
//  AutorizationInteractor.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 8.05.21.
//

import Foundation

final class AuthorizationInteractor {
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
    
    func registerAnonimus(completion: @escaping (Result<User, AuthorizationError>) -> Void) {
        apiDataManager.execute(request: .registerAnon()) { [weak self] result in
            switch result {
            case .success(let user):
                self?.storageDataManager.save(object: user, key: .user)
                completion(.success(user))
            case .failure(let error):
                completion(.failure(AuthorizationError(previousAppError: error)))
            }
        }
    }
    
    func signInWith(googleId: String, completion: @escaping (Result<User, AuthorizationError>) -> Void) {
        apiDataManager.execute(request: .signInWith(googleId: googleId)) { [weak self] result in
            switch result {
            case .success(let user):
                self?.storageDataManager.save(object: user, key: .user)
                completion(.success(user))
            case .failure(let error):
                completion(.failure(AuthorizationError(previousAppError: error)))
            }
        }
    }
    
    func signInWith(name: String, password: String, completion: @escaping (Result<User, AuthorizationError>) -> Void) {
        guard let hashedPassword = CryptoProcessor.sha256(password) else {
            completion(.failure(AuthorizationError(comment: "Can't hash this password")))
            return
        }
        
        apiDataManager.execute(request: .signInWith(name: name, password: hashedPassword)) { [weak self] result in
            switch result {
            case .success(let user):
                self?.storageDataManager.save(object: user, key: .user)
                completion(.success(user))
            case .failure(let error):
                completion(.failure(AuthorizationError(previousAppError: error)))
            }
        }
    }
    
    func createAccount(name: String, email: String, password: String, completion: @escaping (Result<User, AuthorizationError>) -> Void) {
        guard let hashedPassword = CryptoProcessor.sha256(password) else {
            completion(.failure(AuthorizationError(comment: "Can't hash this password")))
            return
        }
        
        apiDataManager.execute(request: .createAccount(name: name, email: email, password: hashedPassword)) { [weak self] result in
            switch result {
            case .success(let user):
                self?.storageDataManager.save(object: user, key: .user)
                completion(.success(user))
            case .failure(let error):
                completion(.failure(AuthorizationError(previousAppError: error)))
            }
        }
    }
    
    func resetPassword(email: String, completion: @escaping((Result<Void, Error>) -> Void)) {
        apiDataManager.execute(request: .resetPassword(email: email)) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(AuthorizationError(previousAppError: error)))
            }
        }
    }
}

private extension APIRequest {
    typealias ParameterName = String
    
    static func registerAnon() -> APIRequest<User> {
        .make(path: "/register/anonymous",
              method: .post,
              needsAuthorization: false,
              queryItems: nil,
              parameters: nil)
    }
    
    static func signInWith(googleId: String) -> APIRequest<User> {
        .make(path: "/auth/google",
              method: .post,
              needsAuthorization: false,
              queryItems: nil,
              parameters: [.googleId: googleId])
    }
    
    static func signInWith(name: String, password: String) -> APIRequest<User> {
        .make(path: "/login/standard",
              method: .post,
              needsAuthorization: false,
              queryItems: nil,
              parameters: [.username: name, .password: password])
    }
    
    static func createAccount(name: String, email: String, password: String) -> APIRequest<User> {
        .make(path: "/register/standard",
              method: .post,
              needsAuthorization: false,
              queryItems: nil,
              parameters: [.username: name, .email: email, .password: password])
    }
    
    static func resetPassword(email: String) -> APIRequest<EmptyResponse> {
        .make(path: "",
              method: .post,
              needsAuthorization: false,
              queryItems: nil,
              parameters: nil)
    }
}

private extension APIRequest.ParameterName {
    static var username: Self { "username" }
    static var password: Self { "password" }
    static var email: Self { "email" }
    static var googleId: Self { "googleId" }
}
