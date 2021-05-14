//
//  SignInScreen.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import GoogleSignIn
import UIKit

final class SignInScreen: Screen<SignInViewModel> {
    private let label = UILabel()
    
    private let signInWithGoogleButton = GIDSignInButton()
    
    override func arrangeView() {
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.addSubview(signInWithGoogleButton)
        signInWithGoogleButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func setupView() {
        label.text = "Sign In"
        
        GIDSignIn.sharedInstance().delegate = viewModel
        GIDSignIn.sharedInstance().presentingViewController = self
    }
}
