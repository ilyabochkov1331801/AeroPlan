//
//  ScreenDepend.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.05.21.
//

import UIKit

public protocol ScreenDependent {
    /// Device's screen width dependent value
    func widthDependent(layoutWidth: CGFloat) -> CGFloat

    /// Device's screen height dependent value
    func heightDependent(layoutHeight: CGFloat) -> CGFloat

    /// Device's screen font size height dependent value
    func fontSizeDependent(layoutHeight: CGFloat) -> CGFloat
}

public extension CGFloat {
    static let canonicalHeight: Self = 812
    static let canonicalWidth: Self = 375
}

public extension ScreenDependent where Self: Numeric {
    
    /// Device's screen width dependent value
    func widthDependent(layoutWidth: CGFloat = .canonicalWidth) -> CGFloat {
        cgFloat.dependent(multiplier: widthMultiplier(layoutWidth: layoutWidth))
    }

    /// Device's screen height dependent value
    func heightDependent(layoutHeight: CGFloat = .canonicalHeight) -> CGFloat {
        cgFloat.dependent(multiplier: heightMultiplier(layoutHeight: layoutHeight))
    }

    /// Device's screen font size height dependent value
    func fontSizeDependent(layoutHeight: CGFloat = .canonicalHeight) -> CGFloat {
        cgFloat.dependent(multiplier: heightMultiplier(layoutHeight: layoutHeight))
    }
    
    // MARK: Clamped
    
    /// Device's screen width dependent value with range bounds
    func widthDependent(layoutWidth: CGFloat = .canonicalWidth, clamped bounds: Range<CGFloat>) -> CGFloat {
        widthDependent(layoutWidth: layoutWidth).clamped(to: bounds)
    }

    /// Device's screen height dependent value with range bounds
    func heightDependent(layoutHeight: CGFloat = .canonicalHeight, clamped bounds: Range<CGFloat>) -> CGFloat {
        heightDependent(layoutHeight: layoutHeight).clamped(to: bounds)
    }

    /// Device's screen font size height dependent value with range bounds
    func fontSizeDependent(layoutHeight: CGFloat = .canonicalHeight, clamped bounds: Range<CGFloat>) -> CGFloat {
        fontSizeDependent(layoutHeight: layoutHeight).clamped(to: bounds)
    }
    
    /// Device's screen width dependent value with range bounds
    func widthDependent(layoutWidth: CGFloat = .canonicalWidth, clamped bounds: PartialRangeThrough<CGFloat>) -> CGFloat {
        widthDependent(layoutWidth: layoutWidth).clamped(to: bounds)
    }
    
    /// Device's screen height dependent value with range bounds
    func heightDependent(layoutHeight: CGFloat = .canonicalHeight, clamped bounds: PartialRangeThrough<CGFloat>) -> CGFloat {
        heightDependent(layoutHeight: layoutHeight).clamped(to: bounds)
    }

    /// Device's screen font size height dependent value with range bounds
    func fontSizeDependent(layoutHeight: CGFloat = .canonicalHeight, clamped bounds: PartialRangeThrough<CGFloat>) -> CGFloat {
        fontSizeDependent(layoutHeight: layoutHeight).clamped(to: bounds)
    }
    
    /// Device's screen width dependent value with range bounds
    func widthDependent(layoutWidth: CGFloat = .canonicalWidth, clamped bounds: PartialRangeFrom<CGFloat>) -> CGFloat {
        widthDependent(layoutWidth: layoutWidth).clamped(to: bounds)
    }
    
    /// Device's screen height dependent value with range bounds
    func heightDependent(layoutHeight: CGFloat = .canonicalHeight, clamped bounds: PartialRangeFrom<CGFloat>) -> CGFloat {
        heightDependent(layoutHeight: layoutHeight).clamped(to: bounds)
    }

    /// Device's screen font size height dependent value with range bounds
    func fontSizeDependent(layoutHeight: CGFloat = .canonicalHeight, clamped bounds: PartialRangeFrom<CGFloat>) -> CGFloat {
        fontSizeDependent(layoutHeight: layoutHeight).clamped(to: bounds)
    }
}

extension Float: ScreenDependent { }
extension Double: ScreenDependent { }
extension Int: ScreenDependent { }
extension CGFloat: ScreenDependent { }
extension UInt: ScreenDependent { }

// MARK: - Private
private extension Numeric {
    var cgFloat: CGFloat {
        let offset: CGFloat
        if let amount = self as? Float {
            offset = CGFloat(amount)
        } else if let amount = self as? Double {
            offset = CGFloat(amount)
        } else if let amount = self as? CGFloat {
            offset = CGFloat(amount)
        } else if let amount = self as? Int {
            offset = CGFloat(amount)
        } else if let amount = self as? UInt {
            offset = CGFloat(amount)
        } else {
            offset = 0.0
        }
        return offset
    }

    func widthMultiplier(layoutWidth: CGFloat) -> CGFloat {
        UIScreen.main.bounds.width / layoutWidth
    }

    func heightMultiplier(layoutHeight: CGFloat) -> CGFloat {
        UIScreen.main.bounds.height / layoutHeight
    }

    func fontSizeMultiplier(layoutHeight: CGFloat) -> CGFloat {
        let heightMultiplier = self.heightMultiplier(layoutHeight: layoutHeight)
        return heightMultiplier >= 1 ? heightMultiplier : heightMultiplier * 1.2
    }
}

private extension CGFloat {
    func precisedTo(digits power: Int) -> CGFloat {
        let delimiter = 10 ^^ power
        return (self * CGFloat(delimiter)).rounded(.toNearestOrEven) / CGFloat(delimiter)
    }

    func dependent(multiplier: CGFloat, precision: Int = 2) -> CGFloat {
        (self * multiplier).precisedTo(digits: precision)
    }
    
    func clamped(to range: Range<CGFloat>) -> CGFloat {
        Swift.max(Swift.min(range.upperBound, self), range.lowerBound)
    }
    
    func clamped(to range: PartialRangeThrough<CGFloat>) -> CGFloat {
        Swift.min(range.upperBound, self)
    }
    
    func clamped(to range: PartialRangeFrom<CGFloat>) -> CGFloat {
        Swift.max(range.lowerBound, self)
    }
}

infix operator ^^
private func ^^ (radix: Int, power: Int) -> CGFloat {
    CGFloat(pow(Double(radix), Double(power)))
}
