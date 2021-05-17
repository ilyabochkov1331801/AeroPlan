//
//  String+Extensions.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 14.05.21.
//

import UIKit

extension String {
    var isValidEmail: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let regex = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!#$*_?@])[a-zA-Z0-9!#$*_?@]{\(minimalPasswordLenth),}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    var isValidUsername: Bool {
        let regex = "[a-zA-Z0-9_]{4,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    func ranges(of substring: String, options: CompareOptions = [], locale: Locale? = nil) -> [NSRange] {
        var ranges: [Range<String.Index>] = []
        while let range = range(of: substring, options: options, range: (ranges.last?.upperBound ?? self.startIndex)..<self.endIndex, locale: locale) {
            ranges.append(range)
        }
        return ranges.map { NSRange($0, in: self) }
    }
    
    func attributeString(with font: UIFont, color: UIColor) -> NSAttributedString {
        NSAttributedString(string: self, attributes: .make(font: font, color: color))
    }
}

private extension String {
    var minimalPasswordLenth: Int { 8 }
}
