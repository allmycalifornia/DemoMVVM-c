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
    private let forgotPasswordButton = UIButton()
    private let forwardButton = UIButton()
    private let letRegisterButton = UIButton()
    private let noAccountLabel = UILabel()

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
        paragraphStyle.firstLineHeadIndent = 16
        
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        clearButton.tintColor = .gray
        clearButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24) // Размер кнопки
        clearButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 18)
        clearButton.addTarget(self, action: #selector(clearPhoneTextField), for: .touchUpInside)

        
        // Phone TextField
        phoneTextField.attributedPlaceholder = NSAttributedString(
            string: "Номер телефона",
            attributes: [
                .font: UIFont.systemFont(ofSize: 18),
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.gray
            ]
        )
        phoneTextField.backgroundColor = .systemGray6
        phoneTextField.borderStyle = .roundedRect
        phoneTextField.keyboardType = .phonePad
        phoneTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // Устанавливаем атрибуты для вводимого текста
        phoneTextField.defaultTextAttributes = [
            .font: UIFont.systemFont(ofSize: 18, weight: .regular),
            .foregroundColor: UIColor.black, // Цвет текста
            .paragraphStyle: paragraphStyle
        ]
        phoneTextField.rightView = clearButton
        phoneTextField.rightViewMode = .whileEditing // Отображать кнопку только при редактировании
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
                .font: UIFont.systemFont(ofSize: 18), // Жирный шрифт и размер
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.gray
            ]
        )
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightView = passwordToggle
        passwordTextField.rightViewMode = .always
        passwordTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // Устанавливаем атрибуты для вводимого текста
        passwordTextField.defaultTextAttributes = [
            .font: UIFont.systemFont(ofSize: 18, weight: .regular),
            .foregroundColor: UIColor.black, // Цвет текста
            .paragraphStyle: paragraphStyle
        ]
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        // Warning Label
        warningLabel.textColor = .red
        warningLabel.textAlignment = .left
        warningLabel.font = UIFont.systemFont(ofSize: 13)
        warningLabel.numberOfLines = 0
        view.addSubview(warningLabel)
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // forgot password button
        forgotPasswordButton.setTitle("Забыли пароль?", for: .normal)
        let buttonText = "Забыли пароль?"
        let attributedText = NSMutableAttributedString(string: buttonText)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, buttonText.count))
        forgotPasswordButton.setAttributedTitle(attributedText, for: .normal)
        forgotPasswordButton.setTitleColor(.systemBlue, for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(warningLabel.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(20)
        }

        // Forward Button
        forwardButton.setTitle("Вперед", for: .normal)
        forwardButton.setTitleColor(.black, for: .normal)
        forwardButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        forwardButton.layer.cornerRadius = 8
        forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        view.addSubview(forwardButton)
        forwardButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        // LetRegisterButton
        letRegisterButton.setTitle("Зарегистрируйтесь", for: .normal)
        let registerButtonText = "Зарегистрируйтесь"
        let registerAttributedText = NSMutableAttributedString(string: registerButtonText)
        registerAttributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, registerButtonText.count))
        letRegisterButton.setAttributedTitle(registerAttributedText, for: .normal)
        letRegisterButton.setTitleColor(.systemBlue, for: .normal)
        letRegisterButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.addSubview(letRegisterButton)
        letRegisterButton.snp.makeConstraints { make in
            make.top.equalTo(forwardButton.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.centerX)
        }
        
        // noAccount Label
        noAccountLabel.text = "У вас нет аккаунта?"
        noAccountLabel.textColor = .black
        noAccountLabel.textAlignment = .right
        noAccountLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.addSubview(noAccountLabel)
        noAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(forwardButton.snp.bottom).offset(16)
            make.trailing.equalTo(view.snp.centerX).offset(-5)
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
        
        // Изменяем цвет текста и цвет заливки кнопки в зависимости от условия
        if forwardButton.isEnabled {
            forwardButton.backgroundColor = .systemYellow // Цвет заливки кнопки, когда активна
            forwardButton.setTitleColor(.white, for: .normal) // Цвет текста кнопки, когда активна
        } else {
            forwardButton.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.5) // Цвет заливки кнопки, когда неактивна
            forwardButton.setTitleColor(.darkGray, for: .normal) // Цвет текста кнопки, когда неактивна
        }
    }

        @objc func forwardButtonTapped() {
            let phoneNumber = phoneTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            let message = viewModel.authenticateUser(phoneNumber: phoneNumber, password: password, users: users)
            warningLabel.text = message
        }
    
    // Действие для кнопки, чтобы она стирала введенные данные
    @objc func clearPhoneTextField() {
        phoneTextField.text = "" // Очищаем текстовое поле
    }
    
    }

