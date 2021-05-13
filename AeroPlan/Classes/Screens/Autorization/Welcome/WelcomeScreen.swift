//
//  WelcomeScreen.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import UIKit

class WelcomeScreen: Screen<WelcomeViewModel> {
    private let appIconImageView = UIImageView(image: R.image.appLogo())
    
    private let adventureButton: UIButton = .make { 
        $0.setTitle("Start adventure", for: .normal)
        $0.setupAeroPlanStyle()
    }
    
    private let signInButton: UIButton = .make {
        $0.setTitle("SignUp", for: .normal)
        $0.setupAeroPlanStyle()
    }
    
    override func arrangeView() {
        view.addSubview(appIconImageView)
        appIconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.addSubview(adventureButton)
        adventureButton.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.bottom).offset(20)
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.greaterThanOrEqualTo(50)
        }
        
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints {
            $0.top.equalTo(adventureButton.snp.bottom).offset(8)
            $0.width.equalTo(adventureButton)
            $0.height.greaterThanOrEqualTo(50)
        }
    }
    
    override func setupView() {
        adventureButton.addTarget(self, action: #selector(startAdventure), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
    }
}

extension WelcomeScreen {
    @objc func startAdventure() {
        viewModel.transitions.openHomeFlow?()
    }
    
    @objc func signIn() {
        viewModel.transitions.openSignIn?()
    }
}
