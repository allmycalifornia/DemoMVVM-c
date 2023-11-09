//
//  TextFieldHelpers.swift
//  DemoMVVM-c
//
//  Created by Борис Кравченко on 07.11.2023.
//

import UIKit

func createClearButton(for target: Any, action: Selector) -> UIButton {
    let clearButton = UIButton(type: .custom)
    clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
    clearButton.tintColor = .gray
    clearButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
    clearButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 18)
    clearButton.addTarget(target, action: action, for: .touchUpInside)
    return clearButton
}

func configureTextField(_ textField: UITextField, placeholder: String, clearButton: UIButton? = nil, isSecure: Bool = false) {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .left
    paragraphStyle.firstLineHeadIndent = 16

    textField.attributedPlaceholder = NSAttributedString(
        string: placeholder,
        attributes: [
            .font: UIFont.systemFont(ofSize: 18),
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.gray
        ]
    )
    textField.backgroundColor = .systemGray6
    textField.borderStyle = .roundedRect
    textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
    textField.defaultTextAttributes = [
        .font: UIFont.systemFont(ofSize: 18, weight: .regular),
        .foregroundColor: UIColor.black,
        .paragraphStyle: paragraphStyle
    ]
    
    if let clearButton = clearButton {
        textField.rightView = clearButton
        textField.rightViewMode = .whileEditing
    }
    
    if isSecure {
        let passwordToggle = PasswordToggleButton(passwordTextField: textField)
        textField.isSecureTextEntry = true
        textField.rightView = passwordToggle
        textField.rightViewMode = .always
    }
}
