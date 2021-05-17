//
//  TermsOfConditionsView.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 14.05.21.
//

import UIKit

class TermsOfConditionsView: UIView {
    private typealias Fonts = AppFonts.TermsOfConditionsView
    private typealias Colors = AppColors.TermsOfConditionsView
    
    private let termsTextView: UITextView = .make {
        $0.isScrollEnabled = false
    }
    
    var termsTransition: ScreenTransition?
    
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TermsOfConditionsView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        termsTransition?()
        return true
    }
}

private extension TermsOfConditionsView {
    func setupView() {
        termsTextView.delegate = self
        // TODO: Add localization
        termsTextView.attributedText = "By creating an account you sign and agree to AeroPlan’s terms of conditions"
            .attributeString(with: Fonts.text, color: Colors.text.normal)
            .attribute(text: "AeroPlan’s terms of conditions",
                       with: .make(font: Fonts.text, color: Colors.text.link).merge(with: [.link: "Terms Link"]))
    }
}
