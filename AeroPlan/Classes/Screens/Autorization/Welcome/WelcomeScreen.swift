//
//  WelcomeScreen.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import UIKit

final class WelcomeScreen: Screen<WelcomeViewModel> {
    private typealias Colors = AppColors.WelcomeScreen
    private typealias Fonts = AppFonts.WelcomeScreen
        
    private let startAdventureButton: UIButton = .make(type: .system) {
        $0.backgroundColor = Colors.startAdventureBackground
        $0.cornerRadius = 7
    }
    
    private let signInButton: UIButton = UIButton(type: .system)
    private let alreadyRegisteredLabel = UILabel()
    private let termsOfConditionsView = TermsOfConditionsView()
    private let illustrationImageView = UIImageView()
    private let titleLabel = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.isNavigationBarHidden = true
        }
    }
    
    override func arrangeView() {
        super.arrangeView()
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview().offset(-143.heightDependent())
        }
        
        view.addSubview(illustrationImageView)
        illustrationImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(184.widthDependent())
            $0.height.equalTo(168.heightDependent())
            $0.top.equalTo(titleLabel.snp.bottom).offset(24.heightDependent())
        }
        
        view.addSubview(startAdventureButton)
        startAdventureButton.snp.makeConstraints {
            $0.top.equalTo(illustrationImageView.snp.bottom).offset(74.heightDependent())
            $0.leading.trailing.equalToSuperview().inset(27.widthDependent())
            $0.height.greaterThanOrEqualTo(50.heightDependent())
        }
        
        let containerStackView: UIStackView = .make {
            $0.axis = .horizontal
            $0.spacing = 3
        }
        
        view.addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(startAdventureButton.snp.bottom).offset(7.heightDependent())
            $0.centerX.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        containerStackView.addArrangedSubview(alreadyRegisteredLabel)
        containerStackView.addArrangedSubview(signInButton)
        
        view.addSubview(termsOfConditionsView)
        termsOfConditionsView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-14.heightDependent())
            $0.leading.trailing.equalToSuperview().inset(45.widthDependent())
        }
    }
    
    override func setupView() {
        super.setupView()
        
        view.backgroundColor = AppColors.WelcomeScreen.background
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        signInButton.setAttributedTitle(viewModel.signInText, for: .normal)
        startAdventureButton.setAttributedTitle(viewModel.startAdventureText, for: .normal)
        
        illustrationImageView.image = viewModel.illustrationImage
        
        titleLabel.attributedText = viewModel.titleText
        alreadyRegisteredLabel.attributedText = viewModel.alreadyRegisteredText
    }
    
    override func setupBinding() {
        super.setupBinding()
        
        termsOfConditionsView.termsTransition = { [weak self] in self?.viewModel.termsOfConditionsTapped() }
        
        startAdventureButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.startAdventureButtonTapped()
            })
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.signInButtonTapped()
            })
            .disposed(by: disposeBag)
    }
}
