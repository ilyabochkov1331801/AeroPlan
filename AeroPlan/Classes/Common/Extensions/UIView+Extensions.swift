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
    
    static func make<Button: UIButton>(type: UIButton.ButtonType, _ closure: (Button) -> Void) -> Button {
        let button = Button(type: type)
        closure(button)
        return button
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
    
    var borderColor: UIColor? {
        get { layer.borderColor.map { UIColor(cgColor: $0) } }
        set { layer.borderColor = newValue?.cgColor }
    }
}
