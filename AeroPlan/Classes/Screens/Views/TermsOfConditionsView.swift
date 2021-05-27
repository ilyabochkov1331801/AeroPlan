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
    
    override init(frame: CGRect) {
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
        return false
    }
}

private extension TermsOfConditionsView {
    func setupView() {
        termsTextView.delegate = self
        termsTextView.attributedText = R.string.localizable.termsOfConditionsText()
            .attributeString(with: Fonts.text, color: Colors.text, alignment: .center)
            .attribute(text: R.string.localizable.termsOfConditionsLink(), with: [.link: ""])
        
        addSubview(termsTextView)
        termsTextView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
