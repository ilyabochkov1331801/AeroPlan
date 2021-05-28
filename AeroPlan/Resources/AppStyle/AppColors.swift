//
//  AppColors.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 17.05.21.
//

import UIKit.UIColor

enum AppColors {
    enum TextFiled {
        static var border: (normal: UIColor, error: UIColor) {
            (R.color.black().unwrapped.withAlphaComponent(0.5), .red)
        }
    }
    
    enum Common {
        static var appTitle: UIColor { R.color.black().unwrapped }
    }
    
    enum WelcomeScreen {
        static var background: UIColor { R.color.white().unwrapped }
        static var signIn: UIColor { R.color.vermilion().unwrapped }
        static var startAdventureTitle: UIColor { R.color.white().unwrapped }
        static var startAdventureBackground: UIColor { R.color.vermilion().unwrapped }
        static var alreadyRegistered: UIColor { R.color.black().unwrapped.withAlphaComponent(0.5) }
    }
    
    enum SignInScreen {
        static var background: UIColor { R.color.white().unwrapped }
        static var logInTitle: UIColor { R.color.white().unwrapped }
        static var logInBackground: UIColor { R.color.vermilion().unwrapped }
        static var forgotPassword: UIColor { R.color.black().unwrapped.withAlphaComponent(0.5) }
        static var newUser: UIColor { R.color.black().unwrapped }
        static var createAccount: UIColor { R.color.vermilion().unwrapped }
        static var logInWithGoogle: UIColor { R.color.black().unwrapped }
    }
    
    enum TermsOfConditionsView {
        static var text: UIColor {R.color.black().unwrapped }
    }
    
    enum CreateAccountScreen {
        static var background: UIColor { R.color.white().unwrapped }
        static var createAccountTitle: UIColor { R.color.white().unwrapped }
        static var createAccountBackground: UIColor { R.color.vermilion().unwrapped }
        static var alreadyRegistered: UIColor { R.color.black().unwrapped.withAlphaComponent(0.5) }
        static var signIn: UIColor { R.color.vermilion().unwrapped }
    }
    
    enum Appearence {
        static var textViewLink: UIColor { R.color.vermilion().unwrapped }
        static var textFiled: UIColor { R.color.black().unwrapped }
    }
}
