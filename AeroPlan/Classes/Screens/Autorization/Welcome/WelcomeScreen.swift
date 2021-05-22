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
        $0.borderColor = AppColors.WelcomeScreen.separator
    }
    
    private let signInButton = UIButton()
    private let termsOfConditionsView = TermsOfConditionsView()
    
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
        
        view.addSubview(termsOfConditionsView)
        termsOfConditionsView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-40)
            $0.leading.trailing.equalToSuperview().inset(35)
        }
    }
    
    override func setupView() {
        view.backgroundColor = AppColors.WelcomeScreen.background
        navigationController?.isNavigationBarHidden = true
        
        signInButton.setAttributedTitle(viewModel.signInButtonText, for: .normal)
    }
    
    override func setupBinding() {
        termsOfConditionsView.termsTransition = { [weak self] in self?.viewModel.termsOfConditionsTapped() }
        
        adventureButton.addTarget(viewModel, action: #selector(viewModel.startAdventureTapped), for: .touchUpInside)
        signInButton.addTarget(viewModel, action: #selector(viewModel.signInTapped), for: .touchUpInside)
    }
}
