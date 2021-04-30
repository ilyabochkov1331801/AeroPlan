//
//  ApiErrors.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 29.04.21.
//

import Foundation

protocol ErrorKeeper {
    var currentError: Error? { get }
    var subError: Error? { get set }
    
    func readDescription() -> String
}

class ApiErrors: ErrorKeeper {
    enum Errors: Error, CaseIterable {
        case failedDecoding
        case failedRequest
    }
    
    var currentError: Error?
    var subError: Error?
    
    func readDescription() -> String {
        return (currentError?.localizedDescription ?? "") + "/" + (subError?.localizedDescription ?? "")
    }
}
