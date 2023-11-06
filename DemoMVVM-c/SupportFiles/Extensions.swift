//
//  Extensions.swift
//  DemoMVVM-c
//
//  Created by Борис Кравченко on 06.11.2023.
//

import UIKit

// MARK: экстеншн для ввода номера документа по маске ХХ ХХ ХХХХХХ при авторизации
extension UITextField {
    func formatAsDocumentNumber() {
        addTarget(self, action: #selector(documentNumberTextFieldDidChange), for: .editingChanged)
    }

    @objc private func documentNumberTextFieldDidChange() {
        let currentText = text ?? ""
        let updatedText = currentText.components(separatedBy: .whitespaces).joined()
        
        if updatedText.count <= 6 {
            var formattedText = ""
            for (index, char) in updatedText.enumerated() {
                formattedText.append(char)
                if (index + 1) % 2 == 0 && index != updatedText.count - 1 {
                    formattedText.append(" ")
                }
            }
            
            text = formattedText
        }
    }
}
