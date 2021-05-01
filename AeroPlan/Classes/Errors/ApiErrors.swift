//
//  ApiErrors.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 29.04.21.
//

import Foundation

protocol AppError: Error {
    var path: String { get }
    var previousAppError: AppError? { get }
    var previousError: Error? { get }
    
    var description: String { get }
    
    init(path: String, previousAppError: AppError?, previousError: Error?)
}

extension AppError {
    var description: String {
        path + ((previousAppError?.description ?? previousError?.localizedDescription).flatMap { "\n" + $0 } ?? "")
    }
}

struct APIError: AppError {
    let path: String
    let previousAppError: AppError?
    let previousError: Error?
    
    init(path: String = #function, previousAppError: AppError? = nil, previousError: Error? = nil) {
        self.path = "API" + path
        self.previousError = previousError
        self.previousAppError = previousAppError
    }
}
