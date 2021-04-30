//
//  ApiDataManager.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 28.04.21.
//

import Foundation

protocol Request {
    associatedtype Model: Codable
    
    var path: String { get }
    var needsAuthorization: Bool { get }
    var arguments: [String: Any] { get }
}

protocol TokenProvider {
    func save(token: String)
    func get() -> String?
}

final class ApiDataManager {
    private var tokenProvider: TokenProvider
    
    init(provider: TokenProvider) {
        self.tokenProvider = provider
    }
    
    func sendRequest<T: Request>(request: T, completion: @escaping ((Result<T.Model, Error>) -> Void)) {
        var urlRequest = URLRequest(url: URL(string: request.path)! , cachePolicy: .reloadIgnoringCacheData)
        
        if request.needsAuthorization {
            guard let token = tokenProvider.get() else {
                assertionFailure("Token not found")
                return
            }
            
            urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
            urlRequest.httpMethod = "GET"
        } else {
            
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else {
                completion(.failure(ApiErrors.Errors.failedRequest))
                return
            }
            
            do {
                completion(.success(try JSONDecoder().decode(T.Model.self, from: data)))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

extension StorageDataManger: TokenProvider {
    private static var key: Key { Key(key: "kToken", isSecure: true) }
    
    func save(token: String) {
        save(object: token, key: StorageDataManger.key)
    }
    
    func get() -> String? {
        get(key: StorageDataManger.key)
    }
}
