//
//  StorageDataManger.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 28.04.21.
//

import Foundation
import KeychainAccess

final class StorageDataManger {
    struct Key {
        let key: String
        let isSecure: Bool
    }
    
    private let keychain: Keychain
    private let userDefaults: UserDefaults
    
    init(service: String, accessGroup: String? = nil) {
        if let accessGroup = accessGroup {
            keychain = Keychain(service: service, accessGroup: accessGroup)
        } else {
            keychain = Keychain(service: service)
        }
        
        userDefaults = UserDefaults(suiteName: accessGroup) ?? .standard
    }
    
    // TODO: Добавить возможность передавать nil и тем самым удалять значение по ключу
    func save(object: StoredProperty, key: Key) {
        do {
            if key.isSecure {
                try keychain.set(NSKeyedArchiver.archivedData(withRootObject: object.coding, requiringSecureCoding: true), key: key.key)
            } else {
                userDefaults.set(object.coding, forKey: key.key)
            }
        } catch {
            print("‼️ - \(error.localizedDescription)")
        }
    }
    
    func get<Value: StoredProperty>(key: Key) -> Value? {
        do {
            if key.isSecure {
                return try keychain.getData(key.key)
                    .flatMap { NSKeyedUnarchiver.unarchiveObject(with: $0) as? NSCoding }
                    .flatMap { Value(coding: $0) }
            } else {
                return userDefaults.data(forKey: key.key)
                    .flatMap { Value(coding: $0 as NSCoding) }
            }
        } catch {
            print("‼️ - \(error.localizedDescription)")
            return nil
        }
    }
}

extension StorageDataManger.Key {
    static var user: Self { Self(key: "kUser", isSecure: true) }
}
