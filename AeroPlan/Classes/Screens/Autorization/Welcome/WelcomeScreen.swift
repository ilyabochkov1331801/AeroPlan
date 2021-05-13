//
//  WelcomeScreen.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import UIKit

final class WelcomeScreen: Screen<WelcomeViewModel> {
    private let appIconImageView = UIImageView(image: R.image.appLogo())
    
    private let adventureButton: UIButton = .make { 
        $0.setTitle("Start adventure", for: .normal)
        $0.setupAeroPlanStyle()
    }
    
    private let separator: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .clear
        lineView.borderWidth = 1.0
        lineView.borderColor = UIColor.lightGray.cgColor
        return lineView
    }()
    
    private let signInButton: UIButton = .make {
        $0.setAttributedTitle("Sign up".make(attributes: [.font: UIFont.systemFont(ofSize: 15)]), for: .normal)
        $0.backgroundColor = .clear
        $0.setTitleColor(.black, for: .normal)
    }
    
    private let termsAndConditionsLabel: UILabel = .make {
        $0.font = UIFont.monospacedSystemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 0
        $0.textAlignment = .center
        let first = NSMutableAttributedString(string: "By creating an account you sign and agree to ", attributes: [.kern: 0.75])
        let second = "AeroPlan’s terms of conditions".make(attributes: [.foregroundColor: UIColor.red,
                                                                          .underlineStyle: NSUnderlineStyle.single.rawValue])
        
        first.append(second)
        $0.attributedText = first
    }
    
    override func arrangeView() {
        view.addSubview(appIconImageView)
        appIconImageView.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.centerY.equalTo(view.safeAreaLayoutGuide).offset(-80)
        }
        
        view.addSubview(adventureButton)
        adventureButton.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.bottom).offset(80)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.greaterThanOrEqualTo(60)
        }
        
        view.addSubview(separator)
        separator.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalTo(UIScreen.main.bounds.width * 0.6)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(adventureButton.snp.bottom).offset(30)
        }
        
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalTo(adventureButton)
        }
        
        view.addSubview(termsAndConditionsLabel)
        termsAndConditionsLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-40)
            $0.leading.trailing.equalToSuperview().inset(35)
        }
    }
    
    override func setupView() {
        view.backgroundColor = R.color.blackHaze()
        navigationController?.isNavigationBarHidden = true
        
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
