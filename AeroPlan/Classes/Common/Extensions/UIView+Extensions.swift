//
//  UIView+Extensions.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import UIKit

extension UIView {
    static func make<View: UIView>(_ closure: (View) -> Void) -> View {
        let view = View()
        closure(view)
        return view
    }
}

// MARK: - Suitable
extension UIView {
    var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    var borderColor: CGColor? {
        get { layer.borderColor }
        set { layer.borderColor = newValue }
    }
}

