//
//  SignInScreen.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import UIKit

final class SignInScreen: Screen<SignInViewModel> {
    private let label = UILabel()
    
    override func arrangeView() {
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func setupView() {
        label.text = "Sign In"
    }
}
