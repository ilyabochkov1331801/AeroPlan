//
//  ResetPasswordScreen.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import UIKit

final class ResetPasswordScreen: Screen<ResetPasswordViewModel> {
    private typealias Colors = AppColors.ResetPasswordScreen
    private typealias Fonts = AppFonts.ResetPasswordScreen
    
    private let appTitleLabel = UILabel()
    private let emailTextField = TextField()
    private let scrollView = UIScrollView()
    
    private let resetPasswordButton: UIButton = .make {
        $0.backgroundColor = Colors.resetPasswordButton
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
        
        contentView.addSubview(appTitleLabel)
        appTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30.widthDependent())
            $0.top.equalToSuperview().offset(155.heightDependent())
        }
        
        contentView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(appTitleLabel.snp.bottom).offset(130.heightDependent())
            $0.leading.trailing.equalToSuperview().inset(30.widthDependent())
            $0.height.equalTo(50.heightDependent())
        }
        
        contentView.addSubview(resetPasswordButton)
        resetPasswordButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30.widthDependent())
            $0.height.equalTo(50.heightDependent())
            $0.top.equalTo(emailTextField.snp.bottom).offset(15.heightDependent())
        }
    }
    
    override func setupView() {
        super.setupView()
        
        view.backgroundColor = Colors.background
        navigationItem.backButtonTitle = ""
        
        scrollView.showsVerticalScrollIndicator = false
        
        appTitleLabel.attributedText = viewModel.appTitleText
        
        emailTextField.attributedPlaceholder = viewModel.emailPlaceholder
        emailTextField.autocapitalizationType = .none
        resetPasswordButton.setAttributedTitle(viewModel.resetPasswordText, for: .normal)
        
        emailTextField.validation = { [weak self] in self?.viewModel.isEmailValid($0) == true }
    }
    
    override func setupBinding() {
        super.setupBinding()
        
        viewModel.errorObservable
            .subscribe { [weak self] error in
                self?.showError(error)
            }
            .disposed(by: bag)
        
        resetPasswordButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .touchUpInside)
        
        keyboardTracker = KeyboardTracker(trackNotification: { [weak self] notification in
            guard let self = self else { return }
            switch notification.event {
            case .willChangeFrame:
                let convertedFrame = self.view.convert(notification.endFrame, from: nil)
                let keyboardHeight = self.view.bounds.height - convertedFrame.minY - self.view.safeAreaInsets.bottom
                self.updateScrollViewBottomInset(value: keyboardHeight + 60,
                                                 animationDuration: notification.timeInterval,
                                                 animationOptions: notification.animationOptions)
            default: break
            }
        })
        keyboardTracker?.startTracking()
    }
}

private extension ResetPasswordScreen {
        @objc func resetPasswordButtonTapped() {
            guard let email = emailTextField.text else {
                return
            }
            viewModel.resetPassword(email: email)
        }
    
    func updateScrollViewBottomInset(value: CGFloat, animationDuration: TimeInterval, animationOptions: UIView.AnimationOptions) {
        scrollView.showsVerticalScrollIndicator = false
        UIView.animate(withDuration: animationDuration, delay: .zero, options: animationOptions) {
            self.scrollView.contentInset = UIEdgeInsets(top: .zero, left: .zero, bottom: value, right: .zero)
            self.scrollView.scrollIndicatorInsets = UIEdgeInsets(top: .zero, left: .zero, bottom: value, right: .zero)
        } completion: { _ in self.scrollView.showsVerticalScrollIndicator = true }
    }
}
