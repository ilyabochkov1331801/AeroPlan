//
//  String + Extension.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 13.05.21.
//

import Foundation

extension String {
    func make(attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        NSAttributedString(string: self, attributes: attributes)
    }
}
