//
//  Optional+Extension.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 17.05.21.
//

import Foundation
import UIKit

extension Optional where Wrapped == UIColor {
    var unwrapped: UIColor {
        guard let unwrapped = self else {
            return UIColor()
        }
        return unwrapped
    }
}

extension Optional where Wrapped == UIFont {
    var unwrapped: UIFont {
        guard let unwrapped = self else {
            return UIFont()
        }
        return unwrapped
    }
}

extension Optional where Wrapped == String {
    var unwrapped: String {
        guard let unwrapped = self else {
            return String()
        }
        return unwrapped
    }
}
