//
//  WelcomeScreen.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import UIKit

final class WelcomeScreen: Screen<WelcomeViewModel> {
    private let label = UILabel()
    
    override func arrangeView() {
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func setupView() {
        label.text = "Welcome"
    }
}
