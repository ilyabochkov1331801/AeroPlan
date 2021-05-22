//
//  ConfigurationReader.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 8.05.21.
//

import Foundation

enum ConfigurationReader {
    static func read() -> Configuration {
        guard let infoDict = Bundle.main.infoDictionary else {
            fatalError("Unable to read config at info.plist file ")
        }
        
        guard let bundleId = infoDict[Keys.backendURL] as? String,
              let backendURL = infoDict[Keys.backendURL] as? String,
              let googleClientId = infoDict[Keys.googleClientId] as? String else {
            fatalError("Unable to read value from infoDict")
        }
        
        return Configuration(backendURL: backendURL.removeDoubleSlash(),
                             bundleId: bundleId,
                             googleClientId: googleClientId)
    }
}

private enum Keys {
    static let backendURL = "BackendURL"
    static let bundleId = "CFBundleIdentifier"
    static let googleClientId = "GoogleClientID"
}

private extension String {
    func removeDoubleSlash() -> String { replacingOccurrences(of: "\\", with: "") }
}
