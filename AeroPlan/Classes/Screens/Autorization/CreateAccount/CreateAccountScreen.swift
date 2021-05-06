//
//  CreateAccountScreen.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import UIKit

final class CreateAccountScreen: Screen<CreateAccountViewModel> {
    private let label = UILabel()
    
    override func arrangeView() {
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func setupView() {
        label.text = "Create Account"
    }
}
