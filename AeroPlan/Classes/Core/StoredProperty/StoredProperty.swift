//
//  StoredProperty.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 29.04.21.
//

import Foundation

protocol StoredProperty {
    var coding: NSCoding { get }
    init?(coding: NSCoding)
}
