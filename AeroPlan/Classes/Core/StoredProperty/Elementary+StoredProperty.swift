//
//  Elementary+StoredProperty.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 29.04.21.
//

import Foundation

extension String: StoredProperty {
    var coding: NSCoding {
        self as NSCoding
    }
    
    init?(coding: NSCoding) {
        guard let string = coding as? String else {
            return nil
        }
        self = string
    }
}
