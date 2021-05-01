//
//  ApiDataManager.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 28.04.21.
//

import Foundation

protocol Request {
    associatedtype Model: Codable
    
    var type: RequestType { get }
    var path: String { get }
    var body: Data { get }
    var needsAuthorization: Bool { get }
    var arguments: [String: String] { get }
}

protocol TokenProvider {
    func save(token: String)
    func get() -> String?
}

enum RequestType: String {
    case get = "GET"
    case post = "POST"
}

final class ApiDataManager {
    private var tokenProvider: TokenProvider
    
    init(provider: TokenProvider) {
        self.tokenProvider = provider
    }
    
    // TODO: - Set backend url, headers, remove force-unwrap
    func sendRequest<T: Request>(request: T, completion: @escaping ((Result<T.Model, Error>) -> Void)) {
        let url = URL(string: request.path)!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = request.arguments.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        var urlRequest = URLRequest(url: components.url!, cachePolicy: .reloadIgnoringCacheData)
        
        if request.needsAuthorization {
            guard let token = tokenProvider.get() else {
                completion(.failure(APIError(path: String(describing: ApiDataManager.self) + " - " + #function + " - Token not found")))
                return
            }
            
            urlRequest.addValue(token, forHTTPHeaderField: "")
        }
        
        urlRequest.httpMethod = request.type.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "")
        urlRequest.httpBody = request.body
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(APIError(previousError: error)))
            }
            guard let data = data else {
                completion(.failure(APIError(path: String(describing: ApiDataManager.self) + " - " + #function + " - Empty response")))
                return
            }
            
            do {
                completion(.success(try JSONDecoder().decode(T.Model.self, from: data)))
            } catch {
                completion(.failure(APIError(previousError: error)))
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
