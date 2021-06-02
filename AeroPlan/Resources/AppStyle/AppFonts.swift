//
//  AppFonts.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 14.05.21.
//

import UIKit.UIFont

// TODO: Update fonts
enum AppFonts {
    enum TermsOfConditionsView {
        static var text: UIFont { .systemFont(ofSize: 15) }
    }
    
    enum Common {
        static var appTitle: (normal: UIFont, highlighted: UIFont) { (.systemFont(ofSize: 15), .systemFont(ofSize: 15)) }
    }
    
    enum WelcomeScreen {
        static var signIn: UIFont { .systemFont(ofSize: 15) }
        static var startAdventure: UIFont { .systemFont(ofSize: 15) }
        static var alreadyRegistered: UIFont { .systemFont(ofSize: 15) }
    }
    
    enum SignInScreen {
        static var logIn: UIFont { .systemFont(ofSize: 15) }
        static var forgotPassword: UIFont { .systemFont(ofSize: 15) }
        static var createAccount: UIFont { .systemFont(ofSize: 15) }
        static var newUser: UIFont { .systemFont(ofSize: 15) }
        static var logInWithGoogle: UIFont { .systemFont(ofSize: 15) }
    }
    
    enum CreateAccountScreen {
        static var createAccount: UIFont { .systemFont(ofSize: 15) }
        static var alreadyRegistered: UIFont { .systemFont(ofSize: 15) }
        static var signIn: UIFont { .systemFont(ofSize: 15) }
    }
    
    enum ResetPasswordScreen {
        static var aeroplan: UIFont { R.font.stolzlLight(size: 33).unwrapped }
        static var travel: UIFont { R.font.stolzlLight(size: 33).unwrapped }
        static var email: UIFont { .systemFont(ofSize: 15) }
        static var resetPassword: UIFont { .systemFont(ofSize: 15) }
    }
    
    enum Appearance {
        static var textViewLink: UIFont { .systemFont(ofSize: 15) }
        static var textField: UIFont { .systemFont(ofSize: 15) }
    }
}
