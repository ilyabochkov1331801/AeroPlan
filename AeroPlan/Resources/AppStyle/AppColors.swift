//
//  AppColors.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 17.05.21.
//

import UIKit.UIColor

enum AppColors {
    enum TextFiled {
        // TODO: Replace colors when design will be ready
        static var border: (normal: UIColor, error: UIColor) { (.gray, .red) }
    }
    
    enum WelcomeScreen {
        static var background: UIColor { R.color.blackHaze().unwrapped }
        static var separator: UIColor { .lightGray }
        static var signInButtonTitle: UIColor { .black }
    }
    
    enum TermsOfConditionsView {
        static var text: UIColor { .black }
    }
    
    enum Appearence {
        static var textViewLink: UIColor { .orange }
    }
}
