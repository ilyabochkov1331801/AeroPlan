//
//  SignInScreen.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import GoogleSignIn
import UIKit

final class SignInScreen: Screen<SignInViewModel> {
    private let signInWithGoogleButton = GIDSignInButton()
    private let usernameTextField = TextFiled()
    private let passwordTextFiled = SecureTextFiled()
    
    private let signInButton: UIButton = .make(type: .system) {
        // TODO: Replace button ui when design will be ready
        $0.setTitle("Sign In", for: .normal)
    }
    
    private let termsOfConditionsView = TermsOfConditionsView()
    
    override func arrangeView() {
        view.addSubview(signInWithGoogleButton)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextFiled)
        view.addSubview(signInButton)
        view.addSubview(termsOfConditionsView)
        
        usernameTextField.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
        
        passwordTextFiled.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(usernameTextField.snp.bottom).offset(30)
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
        
        signInButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordTextFiled.snp.bottom).offset(30)
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
        
        signInWithGoogleButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(usernameTextField.snp.top).offset(-30)
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
        
        termsOfConditionsView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    override func setupView() {        
        GIDSignIn.sharedInstance().delegate = viewModel
        GIDSignIn.sharedInstance().presentingViewController = self
        
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        usernameTextField.validation = { [weak self] in self?.viewModel.isUsernameTextValid($0) ?? true }
        passwordTextFiled.validation = { [weak self] in self?.viewModel.isPasswordTextValid($0) ?? true }
        termsOfConditionsView.termsTransition = { [weak self] in self?.viewModel.termsOfConditionsTapped() }
        
        view.backgroundColor = .white
    }
    
    override func setupBinding() {
        viewModel.errorOccurred = showError
    }
}

private extension SignInScreen {
    @objc func signInButtonTapped() {
        guard let username = usernameTextField.text, let password = passwordTextFiled.text else {
            return
        }
        viewModel.signInWith(username: username, password: password)
    }
}
