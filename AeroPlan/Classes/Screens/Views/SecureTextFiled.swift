//
//  SecureTextFiled.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 14.05.21.
//

import UIKit

class SecureTextFiled: TextFiled {
    private let visibilitySwitcherButton: UIButton = .make(type: .custom) {
        $0.setImage(UIImage(systemName: "Camera"), for: .normal)
        $0.setImage(UIImage(systemName: "Camera"), for: .selected)
    }
    
    private var isTextVisible: Bool = false {
        didSet {
            updateVisibility()
        }
    }
    
    override func setupView() {
        super.setupView()
        
        visibilitySwitcherButton.addTarget(self, action: #selector(visibilitySwitcherTapped), for: .touchUpInside)
        rightView = visibilitySwitcherButton
        rightViewMode = .always
        updateVisibility()
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let visibilitySwitcherSize: CGFloat = 20
        return CGRect(x: bounds.width - visibilitySwitcherSize - 20,
                      y: (bounds.height - visibilitySwitcherSize) / 2,
                      width: visibilitySwitcherSize,
                      height: visibilitySwitcherSize)
    }
}

private extension SecureTextFiled {
    @objc func visibilitySwitcherTapped() {
        isTextVisible.toggle()
    }
    
    func updateVisibility() {
        isSecureTextEntry = !isTextVisible

        if let textRange = textRange(from: beginningOfDocument, to: endOfDocument), let text = text {
            replace(textRange, withText: text)
        }
        
        // Replace images after design will be ready
        visibilitySwitcherButton.isSelected = isTextVisible
    }
}
