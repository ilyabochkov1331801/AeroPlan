//
//  TextFiled.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 14.05.21.
//

import UIKit

class TextFiled: UITextField {
    private typealias Colors = AppColors.TextFiled
    
    var validation: ((String) -> Bool)?
    var paddings = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func resignFirstResponder() -> Bool {
        borderColor = (text.flatMap { self.validation?($0) } ?? true) ? Colors.border.normal : Colors.border.error
        return super.resignFirstResponder()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: paddings)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: paddings)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: paddings)
    }
    
    func setupView() {
        delegate = self
        keyboardType = .asciiCapable
                
        borderWidth = 1
        cornerRadius = 7
        borderColor = Colors.border.normal
    }
}

extension TextFiled: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
