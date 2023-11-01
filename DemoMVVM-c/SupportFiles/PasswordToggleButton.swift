//
//  PasswordToggleButton.swift
//  DemoMVVM-c
//
//  Created by Борис Кравченко on 01.11.2023.
//

import UIKit

class PasswordToggleButton: UIButton {
    var isPasswordHidden: Bool = true {
        didSet {
            passwordTextField!.isSecureTextEntry = isPasswordHidden
        }
    }

    private weak var passwordTextField: UITextField?

    init(passwordTextField: UITextField) {
        super.init(frame: .zero)
        self.passwordTextField = passwordTextField
        setImage(UIImage(systemName: "eye.slash"), for: .normal)
        setImage(UIImage(systemName: "eye"), for: .selected)
        tintColor = .gray
        addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc func togglePasswordVisibility() {
        isPasswordHidden.toggle()
        isSelected = !isPasswordHidden
    }
}
