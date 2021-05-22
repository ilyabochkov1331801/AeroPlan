//
//  NSAttributedString+Extensions.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 14.05.21.
//

import UIKit

extension NSAttributedString {
    typealias Parameters = [NSAttributedString.Key: Any]

    static func merge(strings: NSAttributedString...) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString()
        
        strings.forEach {
            mutableAttributedString.append($0)
        }
        
        return mutableAttributedString
    }
    
    func attribute(text: String, with parameters: Parameters) -> NSAttributedString {
        let mutableCopy = NSMutableAttributedString(attributedString: self)
        let textRanges = self.string.ranges(of: text)
        textRanges.forEach {
            mutableCopy.addAttributes(parameters, range: $0)
        }
        return mutableCopy
    }
}

extension NSAttributedString.Parameters {
    static func make(font: UIFont? = nil, color: UIColor? = nil) -> Self {
        var parameters = Self()
        if let font = font {
            parameters[.font] = font
        }
        if let color = color {
            parameters[.foregroundColor] = color
        }
        return parameters
    }
    
    func merge(with parameters: Self) -> Self {
        var mutableCopy = self
        parameters.forEach {
            mutableCopy[$0] = $1
        }
        return mutableCopy
    }
}
