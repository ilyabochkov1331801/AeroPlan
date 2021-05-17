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
    
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func resignFirstResponder() -> Bool {
        layer.borderColor = (text.flatMap { self.validation?($0) } ?? true) ? Colors.border.normal.cgColor : Colors.border.error.cgColor
        return super.resignFirstResponder()
    }
    
    func setupView() {
        delegate = self
        keyboardType = .asciiCapable
        
        // TODO: Replace this code after merge Alena's pr
        layer.borderWidth = 1
        layer.borderColor = Colors.border.normal.cgColor
    }
}

extension TextFiled: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // TODO: Replace this code after merge Alena's pr
        textField.resignFirstResponder()
        return true
    }
}
