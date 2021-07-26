//
//  APIDataManager.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 28.04.21.
//

import Alamofire
import RxSwift
import RxCocoa

final class APIDataManager {
    private let authInterceptor: AuthInterceptor
    
    private var headers: HTTPHeaders {
        var headers = HTTPHeaders.default
        headers.add(.contentType("application/json"))
        headers.add(.accept("application/json"))
        return headers
    }
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    init(userProvider: UserProvider) {
        authInterceptor = AuthInterceptor(userProvider: userProvider)
    }
    
    @discardableResult func execute<Response: Codable>(request: APIRequest<Response>,
                                                       completion: @escaping ((Result<Response, APIError>) -> Void)) -> DataRequest {
        AF.request(request.url,
                   method: request.method,
                   parameters: request.parameters,
                   encoding: JSONEncoding.default,
                   headers: headers,
                   interceptor: request.needsAuthorization ? authInterceptor : nil)
            .validate()
            .responseDecodable(of: Response.self, queue: .main, decoder: decoder) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(APIError(comment: "\(request.url)", previousError: error)))
                }
            }
    }
    
    @discardableResult func execute(request: APIRequest<EmptyResponse>,
                                    completion: @escaping ((Result<Void, APIError>) -> Void)) -> DataRequest {
        AF.request(request.url,
                   method: request.method,
                   parameters: request.parameters,
                   encoding: JSONEncoding.default,
                   headers: headers,
                   interceptor: request.needsAuthorization ? authInterceptor : nil)
            .validate()
            .response(queue: .main) { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(APIError(comment: "\(request.url)", previousError: error)))
                }
            }
    }
}
