//
//  SecondViewController.swift
//  DemoMVVM-c
//
//  Created by Борис Кравченко on 30.10.2023.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController {
    var viewModel: AuthViewModel!
    var coordinator: AppCoordinator?

    private let logoImageView = UIImageView()
    private let welcomeLabel = UILabel()
    private let phoneTextField = UITextField()
    private let passwordTextField = UITextField()
    private let warningLabel = UILabel()
    private let forwardButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Logo
        logoImageView.image = UIImage(named: "BettaLogoWithName")
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
            make.width.equalTo(120)
            make.height.equalTo(150)
        }

        // Welcome Label
        welcomeLabel.text = "Привет!\nВойдите в Бэтта-банк!"
        welcomeLabel.textAlignment = .left
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 24)
        welcomeLabel.numberOfLines = 0
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 16 // Регулируйте значение отступа здесь
        

        // Phone TextField
        phoneTextField.attributedPlaceholder = NSAttributedString(
            string: "Номер телефона",
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 18), // Жирный шрифт и размер
                .paragraphStyle: paragraphStyle
            ]
        )
        phoneTextField.borderStyle = .roundedRect
        phoneTextField.keyboardType = .phonePad
        view.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        // Password TextField
        let passwordToggle = PasswordToggleButton(passwordTextField: passwordTextField)
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Пароль",
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 18), // Жирный шрифт и размер
                .paragraphStyle: paragraphStyle
            ]
        )
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightView = passwordToggle
        passwordTextField.rightViewMode = .always
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        // Warning Label
        warningLabel.textColor = .red
        warningLabel.textAlignment = .center
        view.addSubview(warningLabel)
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }

        // Forward Button
        forwardButton.setTitle("Вперед", for: .normal)
        forwardButton.backgroundColor = .systemYellow
        forwardButton.layer.cornerRadius = 8
        forwardButton.isEnabled = false // Изначально кнопка неактивна
        forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        view.addSubview(forwardButton)
        forwardButton.snp.makeConstraints { make in
                make.top.equalTo(warningLabel.snp.bottom).offset(20)
                make.centerX.equalToSuperview()
                make.width.equalTo(120)
                make.height.equalTo(40)
            }

        // Добавим наблюдателей для изменения текстовых полей
        phoneTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }

        @objc func textFieldDidChange() {
        // Проверка, заполнены ли оба текстовых поля, чтобы включить/выключить кнопку
            let isPhoneValid = !(phoneTextField.text?.isEmpty ?? true)
            let isPasswordValid = !(passwordTextField.text?.isEmpty ?? true)
            forwardButton.isEnabled = isPhoneValid && isPasswordValid
        }

        @objc func forwardButtonTapped() {
            let phoneNumber = phoneTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            let message = viewModel.authenticateUser(phoneNumber: phoneNumber, password: password, users: users)
            warningLabel.text = message
        }
    }

