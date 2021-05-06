//
//  User+StoredProperty.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 6.05.21.
//

import Foundation

extension User: StoredProperty {
    var coding: NSCoding {
        var dict: [String: Any] = [:]
        dict[Keys.id.rawValue] = id.coding
        dict[Keys.token.rawValue] = token.coding
        return dict.coding
    }
    
    init?(coding: NSCoding) {
        guard let dict = coding as? [String: Any],
              let id = (dict[Keys.id.rawValue] as? NSCoding).flatMap({ String(coding: $0) }),
              let token = (dict[Keys.token.rawValue] as? NSCoding).flatMap({ String(coding: $0) }) else {
            return nil
        }
        self.id = id
        self.token = token
    }
    
    private enum Keys: String {
        case id
        case token
    }
}
