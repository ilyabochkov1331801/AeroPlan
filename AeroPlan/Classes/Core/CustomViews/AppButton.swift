//
//  AppButton.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 17.05.21.
//

import Foundation
import UIKit

class AppButton: UIButton {
    init() {
        super.init(frame: .zero)
        
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStyle() {
        backgroundColor = R.color.vermilion()
        cornerRadius = 10
        borderWidth = 1.0
        borderColor = UIColor.black.withAlphaComponent(0.15)
    }
}
