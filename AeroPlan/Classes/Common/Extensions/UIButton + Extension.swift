//
//  UIButton + Extension.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 13.05.21.
//

import Foundation
import UIKit

extension UIButton {
    func setupAeroPlanStyle() {
        backgroundColor = R.color.vermilion()
        cornerRadius = 10
        borderWidth = 1.0
        borderColor = UIColor.black.withAlphaComponent(0.15).cgColor
    }
}
