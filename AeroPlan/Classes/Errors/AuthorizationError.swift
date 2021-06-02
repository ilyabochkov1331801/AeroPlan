//
//  AutorizationError.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 8.05.21.
//

struct AuthorizationError: AppError {
    let body: String
    let previousAppError: AppError?
    let previousError: Error?
    
    init(comment: String? = nil, previousAppError: AppError? = nil, previousError: Error? = nil, function: String = #function) {
        self.body = "AUT - " + (comment.map { "\($0)" } ?? "") + (Configuration.isDebug ? "\nMethod: \(function)" : "")
        self.previousError = previousError
        self.previousAppError = previousAppError
    }
}
