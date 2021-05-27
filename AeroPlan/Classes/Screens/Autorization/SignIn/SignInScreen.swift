//
//  SignInScreen.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import GoogleSignIn
import UIKit

final class SignInScreen: Screen<SignInViewModel> {
    private typealias Colors = AppColors.SignInScreen
    private typealias Fonts = AppFonts.SignInScreen
    
    private let usernameTextField = TextFiled()
    private let passwordTextFiled = SecureTextFiled()
    private let titleLabel = UILabel()
    private let forgotPasswordButton = UIButton(type: .system)
    private let newUserLabel = UILabel()
    private let createAccountButton = UIButton(type: .system)
    private let separatorImageView = UIImageView()
    private let scrollView = UIScrollView()
    
    private let logInWithGoogleButton: AlignmentButton = .make(type: .system) {
        $0.titleAlignment = .right
        $0.imageAlignment = .left
    }
    
    private let logInButton: UIButton = .make(type: .system) {
        $0.backgroundColor = Colors.logInBackground
        $0.cornerRadius = 7
    }
    
    private var keyboardTracker: KeyboardTracker?

    deinit {
        keyboardTracker?.stopTracking()
        keyboardTracker = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.isNavigationBarHidden = false
        }
        
        navigationItem.backButtonTitle = nil
    }
    
    override func arrangeView() {
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
            $0.leading.trailing.equalToSuperview().inset(30.widthDependent())
            $0.top.equalToSuperview().offset(155.heightDependent())
        }
        
        contentView.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(310.widthDependent())
            $0.height.equalTo(50.heightDependent())
            $0.top.equalTo(titleLabel.snp.bottom).offset(65.heightDependent())
        }
        
        contentView.addSubview(passwordTextFiled)
        passwordTextFiled.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(310.widthDependent())
            $0.height.equalTo(50.heightDependent())
            $0.top.equalTo(usernameTextField.snp.bottom).offset(15.heightDependent())
        }
        
        contentView.addSubview(logInButton)
        logInButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(310.widthDependent())
            $0.height.equalTo(50.heightDependent())
            $0.top.equalTo(passwordTextFiled.snp.bottom).offset(15.heightDependent())
        }
        
        contentView.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.leading.trailing.equalToSuperview().inset(30.widthDependent())
            $0.top.equalTo(logInButton.snp.bottom)
        }
        
        contentView.addSubview(separatorImageView)
        separatorImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(forgotPasswordButton.snp.bottom).offset(15.heightDependent())
            $0.height.equalTo(17)
        }
        
        contentView.addSubview(logInWithGoogleButton)
        logInWithGoogleButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(separatorImageView.snp.bottom).offset(18.heightDependent())
            $0.height.equalTo(50.heightDependent())
            $0.width.equalTo(210.widthDependent())
        }
        
        let containerStackView: UIStackView = .make {
            $0.axis = .horizontal
            $0.spacing = 3
        }
        
        contentView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-30.heightDependent())
            $0.centerX.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        containerStackView.addArrangedSubview(newUserLabel)
        containerStackView.addArrangedSubview(createAccountButton)
    }
    
    override func setupView() {
        view.backgroundColor = Colors.background
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        GIDSignIn.sharedInstance().delegate = viewModel
        GIDSignIn.sharedInstance().presentingViewController = self
        
        logInWithGoogleButton.addTarget(viewModel, action: #selector(viewModel.logInWithGoogleButtonTapped), for: .touchUpInside)
        logInWithGoogleButton.setAttributedTitle(viewModel.logInWithGoogleText, for: .normal)
        logInWithGoogleButton.setImage(viewModel.logInWithGoogleImage, for: .normal)
        
        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        logInButton.setAttributedTitle(viewModel.logInText, for: .normal)
        
        usernameTextField.validation = { [weak self] in self?.viewModel.isUsernameTextValid($0) ?? true }
        usernameTextField.placeholder = viewModel.usernamePlaceholder
        
        passwordTextFiled.validation = { [weak self] in self?.viewModel.isPasswordTextValid($0) ?? true }
        passwordTextFiled.placeholder = viewModel.passwordPlaceholder
                
        titleLabel.attributedText = viewModel.titleText
        
        forgotPasswordButton.setAttributedTitle(viewModel.forgotPasswordText, for: .normal)
        forgotPasswordButton.addTarget(viewModel, action: #selector(viewModel.forgotPasswordButtonTapped), for: .touchUpInside)
        
        newUserLabel.attributedText = viewModel.newUserText
        
        createAccountButton.setAttributedTitle(viewModel.createAccountText, for: .normal)
        createAccountButton.addTarget(viewModel, action: #selector(viewModel.createAccountButtonTapped), for: .touchUpInside)
        
        separatorImageView.image = viewModel.separatorImage
        
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
    
    override func setupBinding() {
        viewModel.errorOccurred = showError
    }
}

private extension SignInScreen {
    @objc func logInButtonTapped() {
        guard let username = usernameTextField.text, let password = passwordTextFiled.text else {
            return
        }
        viewModel.signInWith(username: username, password: password)
    }
    
    func updateScrollViewBottomInset(value: CGFloat, animationDuration: TimeInterval, animationOptions: UIView.AnimationOptions) {
        scrollView.showsVerticalScrollIndicator = false
        UIView.animate(withDuration: animationDuration, delay: .zero, options: animationOptions) {
            self.scrollView.contentInset = UIEdgeInsets(top: .zero, left: .zero, bottom: value, right: .zero)
            self.scrollView.scrollIndicatorInsets = UIEdgeInsets(top: .zero, left: .zero, bottom: value, right: .zero)
        } completion: { _ in self.scrollView.showsVerticalScrollIndicator = true }
    }
}
