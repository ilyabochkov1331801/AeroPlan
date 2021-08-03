//
//  CreateAccountScreen.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import UIKit

final class CreateAccountScreen: Screen<CreateAccountViewModel> {
    private typealias Colors = AppColors.CreateAccountScreen
    private typealias Fonts = AppFonts.CreateAccountScreen
    
    private let usernameTextField = TextField()
    private let emailTextField = TextField()
    private let passwordTextFiled = SecureTextFiled()
    private let titleLabel = UILabel()
    private let signInButton: UIButton = UIButton(type: .system)
    private let alreadyRegisteredLabel = UILabel()
    private let termsOfConditionsView = TermsOfConditionsView()
    private let scrollView = UIScrollView()
    
    private let createAccountButton: UIButton = .make(type: .system) {
        $0.backgroundColor = Colors.createAccountBackground
        $0.cornerRadius = 7
    }
    
    private var keyboardTracker: KeyboardTracker?

    deinit {
        keyboardTracker?.stopTracking()
        keyboardTracker = nil
    }
    
    override func arrangeView() {
        super.arrangeView()
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().priority(.low)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview().offset(-143.heightDependent())
        }
        
        contentView.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(310.widthDependent())
            $0.height.equalTo(50.heightDependent())
            $0.top.equalTo(titleLabel.snp.bottom).offset(65.heightDependent())
        }
        
        contentView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(310.widthDependent())
            $0.height.equalTo(50.heightDependent())
            $0.top.equalTo(usernameTextField.snp.bottom).offset(15.heightDependent())
        }
        
        contentView.addSubview(passwordTextFiled)
        passwordTextFiled.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(310.widthDependent())
            $0.height.equalTo(50.heightDependent())
            $0.top.equalTo(emailTextField.snp.bottom).offset(15.heightDependent())
        }
        
        contentView.addSubview(createAccountButton)
        createAccountButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextFiled.snp.bottom).offset(20.heightDependent())
            $0.leading.trailing.equalToSuperview().inset(27.widthDependent())
            $0.height.greaterThanOrEqualTo(50.heightDependent())
        }
        
        let containerStackView: UIStackView = .make {
            $0.axis = .horizontal
            $0.spacing = 3
        }
        
        contentView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(createAccountButton.snp.bottom).offset(7.heightDependent())
            $0.centerX.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        containerStackView.addArrangedSubview(alreadyRegisteredLabel)
        containerStackView.addArrangedSubview(signInButton)
        
        contentView.addSubview(termsOfConditionsView)
        termsOfConditionsView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-14.heightDependent())
            $0.leading.trailing.equalToSuperview().inset(45.widthDependent())
        }
    }
    
    override func setupView() {
        super.setupView()
        
        view.backgroundColor = Colors.background
        navigationItem.backButtonTitle = ""
        
        signInButton.setAttributedTitle(viewModel.signInText, for: .normal)
        createAccountButton.setAttributedTitle(viewModel.createAccountText, for: .normal)
        
        alreadyRegisteredLabel.attributedText = viewModel.alreadyRegisteredText
        titleLabel.attributedText = viewModel.titleText
        
        emailTextField.placeholder = viewModel.emailPlaceholder
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        usernameTextField.placeholder = viewModel.usernamePlaceholder
        usernameTextField.autocapitalizationType = .none
        passwordTextFiled.placeholder = viewModel.passwordPlaceholder
        passwordTextFiled.autocapitalizationType = .none
    }
    
    override func setupBinding() {
        super.setupBinding()
        
        termsOfConditionsView.termsTransition = { [weak self] in self?.viewModel.termsOfConditionsTapped() }
        
        emailTextField.validation = { [weak self] in self?.viewModel.isEmailTextValid($0) == true }
        passwordTextFiled.validation = { [weak self] in self?.viewModel.isPasswordTextValid($0) == true }
        usernameTextField.validation = { [weak self] in self?.viewModel.isUsernameTextValid($0) == true }
        
        signInButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.signInButtonTapped()
            })
            .disposed(by: disposeBag)
        
        createAccountButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.createAccountButtonTapped()
            })
            .disposed(by: disposeBag)
        
        keyboardTracker = KeyboardTracker(trackNotification: { [weak self] notification in
            guard let self = self else { return }
            switch notification.event {
            case .willChangeFrame:
                let convertedFrame = self.view.convert(notification.endFrame, from: nil)
                let keyboardHeight = self.view.bounds.height - convertedFrame.minY - self.view.safeAreaInsets.bottom
                self.updateScrollViewBottomInset(value: keyboardHeight,
                                                 animationDuration: notification.timeInterval,
                                                 animationOptions: notification.animationOptions)
            default: break
            }
        })
        keyboardTracker?.startTracking()
    }
}

private extension CreateAccountScreen {
    func createAccountButtonTapped() {
        guard let username = usernameTextField.text,
              let password = passwordTextFiled.text,
              let email = emailTextField.text else {
            return
        }
        viewModel.createAccount(name: username, email: email, password: password)
    }
    
    func updateScrollViewBottomInset(value: CGFloat, animationDuration: TimeInterval, animationOptions: UIView.AnimationOptions) {
        scrollView.showsVerticalScrollIndicator = false
        UIView.animate(withDuration: animationDuration, delay: .zero, options: animationOptions) {
            self.scrollView.contentInset = UIEdgeInsets(top: .zero, left: .zero, bottom: value, right: .zero)
            self.scrollView.scrollIndicatorInsets = UIEdgeInsets(top: .zero, left: .zero, bottom: value, right: .zero)
        } completion: { _ in self.scrollView.showsVerticalScrollIndicator = true }
    }
}
