//
//  APIRequest.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 6.05.21.
//

import Alamofire

struct APIRequest<Response: Codable> {
    let url: URLConvertible
    let method: Alamofire.HTTPMethod
    let needsAuthorization: Bool
    let parameters: Parameters?
    
    static func make(path: String,
                     method: Alamofire.HTTPMethod,
                     needsAuthorization: Bool,
                     queryItems: [URLQueryItem]?,
                     parameters: Parameters?) -> Self {
        guard var components = URLComponents(string: Configuration.global.backendURL + path) else {
            return Self(url: Configuration.global.backendURL + path,
                        method: method,
                        needsAuthorization: needsAuthorization,
                        parameters: parameters)
        }
        components.queryItems = queryItems
        return Self(url: components,
                    method: method,
                    needsAuthorization: needsAuthorization,
                    parameters: parameters)
    }
}
