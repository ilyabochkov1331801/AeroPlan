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
    
    // TODO: Добавить ссылку на бэкенд в файл конфигурации, читать оттуда и сетать в начало пути
    static func make(path: String,
                     method: Alamofire.HTTPMethod = .get,
                     needsAuthorization: Bool = true,
                     queryItems: [URLQueryItem]? = nil,
                     parameters: Parameters? = nil) -> Self {
        guard var components = URLComponents(string: path) else {
            return Self(url: path, method: method, needsAuthorization: needsAuthorization, parameters: parameters)
        }
        components.queryItems = queryItems
        return Self(url: components, method: method, needsAuthorization: needsAuthorization, parameters: parameters)
    }
}
