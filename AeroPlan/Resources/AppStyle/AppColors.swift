//
//  AppColors.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 17.05.21.
//

import UIKit.UIColor

enum AppColor {
    enum WelcomeScreen {
        static var background: UIColor { R.color.blackHaze().unwrapped }
        static var separator: UIColor { .lightGray }
        static var signInButtonTitle: UIColor { .black }
    }
    
    enum TermsOfConditionsView {
        static var text: (normal: UIColor, link: UIColor) { (.black, .red) }
    }
}

enum AppFont {
    enum WelcomeScreen {
        static var signInButtonTitle: UIFont { UIFont.systemFont(ofSize: 15) }
    }
    
    enum TermsOfConditionsView {
        static var text: UIFont { UIFont.monospacedSystemFont(ofSize: 12, weight: .regular) }
    }
}
