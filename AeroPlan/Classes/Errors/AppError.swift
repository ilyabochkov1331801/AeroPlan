//
//  AppError.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 6.05.21.
//

public protocol AppError: Error {    
    var body: String { get }
    var previousAppError: AppError? { get }
    var previousError: Error? { get }
    
    var description: String { get }
    
    init(comment: String?, previousAppError: AppError?, previousError: Error?, function: String)
}

extension AppError {
    var description: String {
        body + ((previousAppError?.description ?? previousError?.localizedDescription).flatMap { "\n ---------- \n" + $0 } ?? "")
    }
}
