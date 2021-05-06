//
//  APIError.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 29.04.21.
//

struct APIError: AppError {
    let body: String
    let previousAppError: AppError?
    let previousError: Error?
    
    init(comment: String? = nil, previousAppError: AppError? = nil, previousError: Error? = nil, function: String = #function) {
        self.body = "API" + function + (comment ?? "")
        self.previousError = previousError
        self.previousAppError = previousAppError
    }
}
