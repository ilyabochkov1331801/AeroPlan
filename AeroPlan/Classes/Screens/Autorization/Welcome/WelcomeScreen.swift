//
//  WelcomeScreen.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import UIKit

final class WelcomeScreen: Screen<WelcomeViewModel> {
    private let appIconImageView = UIImageView(image: R.image.welcome.appLogo())
    
    private let adventureButton: AppButton = .make {
        $0.setTitle(R.string.localizable.welcomeScreenStartAdventure(), for: .normal)
    }
    
    private let separatorView: UIView = .make {
        $0.backgroundColor = .clear
        $0.borderWidth = 1.0
        $0.borderColor = AppColor.WelcomeScreen.separator
    }
    
    private let signInButton: UIButton = .make {
        $0.setAttributedTitle(R.string.localizable.welcomeScreenSignUp().make(attributes: [.font: AppFont.WelcomeScreen.signInButtonTitle]), for: .normal)
        $0.backgroundColor = .clear
        $0.setTitleColor(AppColor.WelcomeScreen.signInButtonTitle, for: .normal)
    }
    
    private let termsAndConditionsLabel: UILabel = .make {
        $0.font = AppFont.TermsOfConditionsView.text
        $0.numberOfLines = 0
        $0.textAlignment = .center
        let first = NSMutableAttributedString(string: R.string.localizable.termsOfUse(), attributes: [.kern: 0.75])
        let second = R.string.localizable.linkTermsOfUse().make(attributes: [.foregroundColor: AppColor.TermsOfConditionsView.text.link,
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
        
        view.addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalTo(UIScreen.main.bounds.width * 0.6)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(adventureButton.snp.bottom).offset(30)
        }
        
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(20)
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
        view.backgroundColor = AppColor.WelcomeScreen.background
        navigationController?.isNavigationBarHidden = true
        
        adventureButton.addTarget(self, action: #selector(startAdventureTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        termsAndConditionsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(termsOfUseTapped)))
    }
}

extension WelcomeScreen {
    @objc func startAdventureTapped(sender: UIButton) {
        viewModel.transitions.openHomeFlow?()
    }
    
    @objc func signInTapped(sender: UIButton) {
        viewModel.transitions.openSignIn?()
    }
    
    @objc func termsOfUseTapped(sender: UILabel) {
        viewModel.transitions.openPrivacy?()
    }
}
