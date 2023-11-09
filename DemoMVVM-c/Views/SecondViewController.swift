//
//  SecondViewController.swift
//  DemoMVVM-c
//
//  Created by Борис Кравченко on 30.10.2023.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    var viewModel: AuthViewModel!
    var coordinator: AppCoordinator?
    
    // MARK: задаём типы данных для составляющих элементов
    private let notification = NotificationCenter.default
    private let contentView = UIView()
    private let logoImageView = UIImageView()
    private let welcomeLabel = UILabel()
    private let phoneTextField = UITextField()
    private let documentNumberTextField = UITextField()
    private let passwordTextField = UITextField()
    private let warningPasswordLabel = UILabel()
    private let warningPhoneLabel = UILabel()
    private let warningDocumentLabel = UILabel()
    private let forgotPasswordButton = UIButton()
    private let forwardButton = UIButton()
    private let letRegisterButton = UIButton()
    private let noAccountLabel = UILabel()
    
    // MARK: задаём параметры переключателя UISegmentControl
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [TextLabels.LoginVC.phone, TextLabels.LoginVC.document])
            segmentedControl.selectedSegmentIndex = 0
            // Устанавливаем стиль и цвета для нормального состояния
            segmentedControl.setTitleTextAttributes([
                .font: textAttributes.segmentControlTextFont,
                .foregroundColor: textAttributes.segmentControlColorNormal
            ], for: .normal)
            // Устанавливаем стиль и цвета для выбранного состояния
            segmentedControl.setTitleTextAttributes([
                .font: textAttributes.segmentControlTextFont,
                .foregroundColor: textAttributes.segmentControlColorSelected
            ], for: .selected)
            // Убираем фон
            segmentedControl.backgroundColor = .clear
            // Убираем обводку сегментов
            segmentedControl.layer.borderWidth = 0
            segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
            return segmentedControl
        }()


    // MARK: life cycle - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // MARK: ViewModel
        viewModel = AuthViewModel()
        viewModel.coordinator = coordinator
        showPhoneTextField()
        documentNumberTextField.formatAsDocumentNumber() // ввод номера документа по маске
        
        phoneTextField.delegate = self
        passwordTextField.delegate = self
        
        // MARK: методы NotificationCenter для открытия и скрытия клавитатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // MARK: добавляем элементы на экран
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // Logo
        logoImageView.image = UIImage(named: "BettaLogoWithName")
        logoImageView.contentMode = .scaleAspectFill
        contentView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
            make.width.equalTo(120)
            make.height.equalTo(150)
        }

        // Welcome Label
        welcomeLabel.text = TextLabels.LoginVC.welcomeText
        welcomeLabel.textAlignment = .left
        welcomeLabel.font = textAttributes.welcomeLabel
        welcomeLabel.numberOfLines = 0
        contentView.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // Добавляем UISegmentedControl
        contentView.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        //MARK: TextFileds attributes
        let clearPhoneNumberButton = createClearButton(for: self, action: #selector(clearPhoneTextField))
        let clearDocumentNumberButton = createClearButton(for: self, action: #selector(clearDocumentNumberTextField))
        
        //MARK: Phone TextField
        configureTextField(phoneTextField, placeholder: TextLabels.LoginVC.phoneNumber, clearButton: clearPhoneNumberButton)
        phoneTextField.keyboardType = .phonePad
                contentView.addSubview(phoneTextField)
                phoneTextField.snp.makeConstraints { make in
                    make.top.equalTo(segmentedControl.snp.bottom).offset(20)
                    make.leading.trailing.equalToSuperview().inset(20)
                }
        
        //MARK: Document Number TextField
        configureTextField(documentNumberTextField, placeholder: TextLabels.LoginVC.documentNumber, clearButton: clearDocumentNumberButton)
        documentNumberTextField.keyboardType = .phonePad
        contentView.addSubview(documentNumberTextField)
                documentNumberTextField.snp.makeConstraints { make in
                    make.top.equalTo(segmentedControl.snp.bottom).offset(20)
                    make.leading.trailing.equalToSuperview().inset(20)
                }
    
        //MARK: Password TextField
        configureTextField(passwordTextField, placeholder: TextLabels.LoginVC.password, isSecure: true)
        contentView.addSubview(passwordTextField)
                passwordTextField.snp.makeConstraints { make in
                    make.top.equalTo(phoneTextField.snp.bottom).offset(25)
                    make.leading.trailing.equalToSuperview().inset(20)
                }
        passwordTextField.layoutIfNeeded()
                

        // Warning Password Label
        warningPasswordLabel.textColor = textAttributes.warningTextColor
        warningPasswordLabel.textAlignment = textAttributes.warningTextAligment
        warningPasswordLabel.font = textAttributes.warningLabels
        contentView.addSubview(warningPasswordLabel)
        warningPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // Warning Phone Label
        warningPhoneLabel.textColor = textAttributes.warningTextColor
        warningPhoneLabel.textAlignment = textAttributes.warningTextAligment
        warningPhoneLabel.font = textAttributes.warningLabels
        contentView.addSubview(warningPhoneLabel)
        warningPhoneLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // Warning Document Label
        warningDocumentLabel.textColor = textAttributes.warningTextColor
        warningDocumentLabel.textAlignment = textAttributes.warningTextAligment
        warningDocumentLabel.font = textAttributes.warningLabels
        contentView.addSubview(warningDocumentLabel)
        warningDocumentLabel.snp.makeConstraints { make in
            make.top.equalTo(documentNumberTextField.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // forgot password button
        forgotPasswordButton.setTitle(TextLabels.LoginVC.forgotPassword, for: .normal)
        let buttonText = TextLabels.LoginVC.forgotPassword
        let attributedText = NSMutableAttributedString(string: buttonText)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, buttonText.count))
        forgotPasswordButton.setAttributedTitle(attributedText, for: .normal)
        forgotPasswordButton.setTitleColor(.systemBlue, for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        contentView.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        // Forward Button
        forwardButton.setTitle(TextLabels.LoginVC.next, for: .normal)
        forwardButton.setTitleColor(.black, for: .normal)
        forwardButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        forwardButton.layer.cornerRadius = 8
        forwardButton.backgroundColor = .systemGray5
        forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        contentView.addSubview(forwardButton)
        forwardButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        // LetRegisterButton
        letRegisterButton.setTitle(TextLabels.LoginVC.register, for: .normal)
        let registerButtonText = TextLabels.LoginVC.register
        let registerAttributedText = NSMutableAttributedString(string: registerButtonText)
        registerAttributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, registerButtonText.count))
        letRegisterButton.setAttributedTitle(registerAttributedText, for: .normal)
        letRegisterButton.setTitleColor(.systemBlue, for: .normal)
        letRegisterButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        letRegisterButton.addTarget(self, action: #selector(letRegisterButtonTapped), for: .touchUpInside)
        view.addSubview(letRegisterButton)
        letRegisterButton.snp.makeConstraints { make in
            make.top.equalTo(forwardButton.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.centerX)
        }
        
        // noAccount Label
        noAccountLabel.text = TextLabels.LoginVC.noAccount
        noAccountLabel.textColor = .black
        noAccountLabel.textAlignment = .right
        noAccountLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.addSubview(noAccountLabel)
        noAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(forwardButton.snp.bottom).offset(16)
            make.trailing.equalTo(view.snp.centerX).offset(-5)
        }

        //MARK: наблюдатели для изменения текстовых полей
        phoneTextField.addTarget(self, action: #selector(phoneTextFieldDidChange), for: .editingChanged)
        documentNumberTextField.addTarget(self, action: #selector(documentNumberTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
    }

    //MARK: Проверка валидности номера телефона
    @objc func phoneTextFieldDidChange() {
        let phoneNumber = phoneTextField.text ?? ""
        let isPhoneValid = phoneNumber.count == 12 && phoneNumber.hasPrefix("+")

        // Определение сообщения об ошибке
        var phoneError = ""
        
        if !isPhoneValid {
            phoneError = TextLabels.LoginVC.phoneError
        }
        
        // Отображение сообщения об ошибке
        warningPhoneLabel.text = phoneError

        // Проверка и обновление кнопки "Вперед"
        updateForwardButton()
    }

    //MARK: Проверка валидности номера документа
    @objc func documentNumberTextFieldDidChange() {
        let documentNumber = documentNumberTextField.text ?? ""
        let isDocumentValid = documentNumber.count == 12

        // Определение сообщения об ошибке
        var documentError = ""
        
        if !isDocumentValid {
            documentError = TextLabels.LoginVC.documentError
        }
        
        // Отображение сообщения об ошибке
        warningDocumentLabel.text = documentError

        // Проверка и обновление кнопки "Вперед"
        updateForwardButton()
    }

    //MARK: Проверка валидности пароля
    @objc func passwordTextFieldDidChange() {
        let password = passwordTextField.text ?? ""
        let isPasswordValid = (6...20).contains(password.count)

        // Определение сообщения об ошибке
        var passwordError = ""
        
        if !isPasswordValid {
            passwordError = TextLabels.LoginVC.passwordError
        }
        
        // Отображение сообщения об ошибке
        warningPasswordLabel.text = passwordError

        // Проверка и обновление кнопки "Вперед"
        updateForwardButton()
    }

    //MARK: Проверка и обновление кнопки "Вперед"
    func updateForwardButton() {
        // Проверка валидности номера телефона, номера документа и пароля
        let phoneNumber = phoneTextField.text ?? ""
        let isPhoneValid = phoneNumber.count == 12 && phoneNumber.hasPrefix("+")
        
        let documentNumber = documentNumberTextField.text ?? ""
        let isDocumentValid = documentNumber.count == 12
        
        let password = passwordTextField.text ?? ""
        let isPasswordValid = (6...20).contains(password.count)
        
        // Проверка и обновление кнопки "Вперед"
        forwardButton.isEnabled = (isPhoneValid || isDocumentValid) && isPasswordValid

        if forwardButton.isEnabled {
            forwardButton.backgroundColor = .systemYellow
            forwardButton.setTitleColor(.white, for: .normal)
        } else {
            forwardButton.backgroundColor = .systemYellow.withAlphaComponent(0.5)
            forwardButton.setTitleColor(.black, for: .normal)
        }
    }

        //MARK: проверка введенных данных авторизации
        @objc func forwardButtonTapped() {
            let phoneNumber = phoneTextField.text ?? ""
            let documentNumber = documentNumberTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            let message = viewModel.authenticateUser(phoneNumber: phoneNumber, documentNumber: documentNumber, password: password, users: users)
            warningPasswordLabel.text = message
        }
    
        // Действие для кнопки xmark, чтобы она стирала введенные данные
        @objc func clearPhoneTextField() {
        phoneTextField.text = "" // Очищаем текстовое поле
        }
    
        // Действие для кнопки xmark, чтобы она стирала введенные данные
        @objc func clearDocumentNumberTextField() {
        documentNumberTextField.text = "" // Очищаем текстовое поле
        }
    
        // Действие кнопки "Забыли пароль?"
        @objc func forgotPasswordButtonTapped() {
            coordinator?.showThirdScreen()  // пока стоит заглушка
        }
    
        // Действие кнопки "Зарегистрируйтесь"
        @objc func letRegisterButtonTapped() {
            coordinator?.showThirdScreen()  // пока стоит заглушка
        }
    
    
        //MARK: метод показа клавиатуры и подъёма экрана наверх
        @objc func keyboardWillShow(notification: NSNotification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let buttonFrameInWindow = forwardButton.convert(forwardButton.bounds, to: nil)
                let bottomOfButton = buttonFrameInWindow.maxY

                // Рассчитываем, насколько нужно поднять экран
                let offset = bottomOfButton + 10 - (self.view.frame.size.height - keyboardSize.height)

                if offset > 0 {
                    self.view.frame.origin.y -= offset
                }
            }
        }

        // метод скрытия клавиатуры
        @objc func keyboardWillHide(notification: NSNotification) {
            self.view.frame.origin.y = 0
        }
    
        // метод выбора способа авторизации - телефон или документ
        @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
                switch sender.selectedSegmentIndex {
                case 0:
                    showPhoneTextField()
                case 1:
                    showDocumentNumberTextField()
                default:
                    break
                }
            }

            func showPhoneTextField() {
                phoneTextField.isHidden = false
                documentNumberTextField.isHidden = true
                documentNumberTextField.text = ""
                warningDocumentLabel.text = ""
                
            }

            func showDocumentNumberTextField() {
                phoneTextField.isHidden = true
                documentNumberTextField.isHidden = false
                phoneTextField.text = ""
                warningPhoneLabel.text = ""
            }

}



// MARK: скрытие клавиатуры по нажатию на return
extension SecondViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}


// MARK: подстановка символов +7 в начало поля ввода номера телефона
extension SecondViewController {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == phoneTextField {
            if !textField.text!.hasPrefix("+7") {
                textField.text = "+7" + textField.text!
            }
        }
    }
}
