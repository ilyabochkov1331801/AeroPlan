//
//  ResetPasswordScreen.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import UIKit

final class ResetPasswordScreen: Screen<ResetPasswordViewModel> {
    private let label = UILabel()
    
    override func arrangeView() {
        super.arrangeView()
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func setupView() {
        super.setupView()
        
        label.text = "Reset Password"
    }
}
