//
//  Configuration.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 8.05.21.
//

import Foundation

struct Configuration {
    static let global = ConfigurationReader.read()
    
    let backendURL: String
    let bundleId: String
}
