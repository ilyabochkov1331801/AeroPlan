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
