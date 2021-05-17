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
