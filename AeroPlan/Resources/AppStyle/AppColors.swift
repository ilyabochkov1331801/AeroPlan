//
//  AppColors.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 14.05.21.
//

import UIKit.UIColor

enum AppColors {
    enum TextFiled {
        // TODO: Replace colors when design will be ready
        static var border: (normal: UIColor, error: UIColor) { (.gray, .red) }
    }
    
    enum TermsOfConditionsView {
        static var text: (normal: UIColor, link: UIColor) { (.black, .orange) }
    }
}
