//
//  AuthInterceptor.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 6.05.21.
//

import Alamofire

protocol UserProvider {
    var user: User? { get set }
}

final class AuthInterceptor: RequestInterceptor {
    private var userProvider: UserProvider
    
    init(userProvider: UserProvider) {
        self.userProvider = userProvider
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if let token = userProvider.user?.token {
            urlRequest.headers.add(.authorization(bearerToken: token))
        }

        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let errorCode = error.asAFError?.responseCode, errorCode == 401, let user = userProvider.user else {
            completion(.doNotRetry)
            return
        }
        
        let refreshTokenRequest: APIRequest<User> = .refreshToken(for: user)
        
        session
            .request(refreshTokenRequest.url,
                     method: refreshTokenRequest.method,
                     parameters: refreshTokenRequest.parameters,
                     encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: User.self) { [weak self] response in
                switch response.result {
                case .success(let updatedUser):
                    self?.userProvider.user = updatedUser
                    completion(.retry)
                case .failure(let error):
                    self?.userProvider.user = nil
                    completion(.doNotRetryWithError(APIError(previousError: error)))
                }
            }
    }
}

extension StorageDataManger: UserProvider {
    var user: User? {
        get { get(key: .user) }
        set { newValue.map { save(object: $0, key: .user) } }
    }
}

private extension APIRequest {
    static func refreshToken(for user: User) -> APIRequest<User> {
        .make(path: "/verification", method: .post, needsAuthorization: false, queryItems: nil, parameters: ["id": user.id, "token": user.token])
    }
}
