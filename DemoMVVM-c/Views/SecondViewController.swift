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
    
    private let notification = NotificationCenter.default
    private let contentView = UIView()
    private let logoImageView = UIImageView()
    private let welcomeLabel = UILabel()
    private let phoneTextField = UITextField()
    private let documentNumberTextField = UITextField()
    private let passwordTextField = UITextField()
    private let warningLabel = UILabel()
    private let forgotPasswordButton = UIButton()
    private let forwardButton = UIButton()
    private let letRegisterButton = UIButton()
    private let noAccountLabel = UILabel()
    
    private let segmentedControl: UISegmentedControl = {
            let segmentedControl = UISegmentedControl(items: ["Телефон", "Документ"])
            segmentedControl.selectedSegmentIndex = 0

            // Устанавливаем стиль и цвета для нормального состояния
            segmentedControl.setTitleTextAttributes([
                .font: UIFont.boldSystemFont(ofSize: 18), // жирный шрифт 18 размера
                .foregroundColor: UIColor.black // цвет текста
            ], for: .normal)

            // Устанавливаем стиль и цвета для выбранного состояния
            segmentedControl.setTitleTextAttributes([
                .font: UIFont.boldSystemFont(ofSize: 18), // жирный шрифт 18 размера
                .foregroundColor: UIColor.systemBlue // цвет текста
            ], for: .selected)

            // Устанавливаем цвет подчеркивания для выбранного сегмента
            segmentedControl.setTitleTextAttributes([
                .foregroundColor: UIColor.systemYellow // цвет подчеркивания
            ], for: .selected)

            // Убираем фон
            segmentedControl.backgroundColor = .clear
            // Убираем обводку сегментов
            segmentedControl.layer.borderWidth = 0

            segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
            return segmentedControl
        }()



    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel = AuthViewModel()
        viewModel.coordinator = coordinator
        
        phoneTextField.delegate = self
        passwordTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
        welcomeLabel.text = "Привет!\nВойдите в Бэтта-банк!"
        welcomeLabel.textAlignment = .left
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 24)
        welcomeLabel.numberOfLines = 0
        contentView.addSubview(welcomeLabel)
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
        
        // Добавляем UISegmentedControl
        contentView.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        showPhoneTextField()

        
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
        phoneTextField.defaultTextAttributes = [
            .font: UIFont.systemFont(ofSize: 18, weight: .regular),
            .foregroundColor: UIColor.black, // Цвет текста
            .paragraphStyle: paragraphStyle
        ]
        phoneTextField.rightView = clearButton
        phoneTextField.rightViewMode = .whileEditing // Отображать кнопку только при редактировании
        contentView.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // Document Number TextField
        documentNumberTextField.attributedPlaceholder = NSAttributedString(
            string: "Номер документа",
            attributes: [
                .font: UIFont.systemFont(ofSize: 18),
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.gray
            ]
        )
        documentNumberTextField.backgroundColor = .systemGray6
        documentNumberTextField.borderStyle = .roundedRect
        documentNumberTextField.keyboardType = .phonePad
        documentNumberTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        documentNumberTextField.defaultTextAttributes = [
            .font: UIFont.systemFont(ofSize: 18, weight: .regular),
            .foregroundColor: UIColor.black, // Цвет текста
            .paragraphStyle: paragraphStyle
        ]
        documentNumberTextField.rightView = clearButton
        documentNumberTextField.rightViewMode = .whileEditing // Отображать кнопку только при редактировании
        contentView.addSubview(documentNumberTextField)
        documentNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
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
        passwordTextField.defaultTextAttributes = [
            .font: UIFont.systemFont(ofSize: 18, weight: .regular),
            .foregroundColor: UIColor.black, // Цвет текста
            .paragraphStyle: paragraphStyle
        ]
        contentView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        // Warning Label
        warningLabel.textColor = .red
        warningLabel.textAlignment = .left
        warningLabel.font = UIFont.systemFont(ofSize: 13)
        warningLabel.numberOfLines = 0
        contentView.addSubview(warningLabel)
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
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        contentView.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(warningLabel.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }

        // Forward Button
        forwardButton.setTitle("Вперед", for: .normal)
        forwardButton.setTitleColor(.black, for: .normal)
        forwardButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        forwardButton.layer.cornerRadius = 8
        forwardButton.backgroundColor = .systemGray5
        forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        contentView.addSubview(forwardButton)
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
        letRegisterButton.addTarget(self, action: #selector(letRegisterButtonTapped), for: .touchUpInside)
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
        // Проверка валидности номера телефона
        let phoneNumber = phoneTextField.text ?? ""
        let isPhoneValid = phoneNumber.count == 12 && phoneNumber.hasPrefix("+")
        
        // Проверка валидности пароля
        let password = passwordTextField.text ?? ""
        let isPasswordValid = (6...20).contains(password.count)
        
        // Определение сообщений об ошибках
        var phoneError = ""
        var passwordError = ""
        
        if !isPhoneValid {
            phoneError = "Номер телефона должен содержать 11 цифр"
        }
        
        if !isPasswordValid {
            passwordError = "Пароль должен содержать от 6 до 20 символов"
        }
        
        // Отображение сообщений об ошибках
        warningLabel.text = phoneError + "\n" + passwordError
        
        // Включение/выключение кнопки "Вперед" и изменение цвета
        forwardButton.isEnabled = isPhoneValid && isPasswordValid
        
        if forwardButton.isEnabled {
            forwardButton.backgroundColor = .systemYellow
            forwardButton.setTitleColor(.white, for: .normal)
        } else {
            forwardButton.backgroundColor = .systemYellow.withAlphaComponent(0.5)
            forwardButton.setTitleColor(.black, for: .normal)
        }
        
    }

        // проверка введенных данных авторизации
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
    
        // Действие кнопки "Забыли пароль?"
        @objc func forgotPasswordButtonTapped() {
            coordinator?.showThirdScreen()  // пока стоит заглушка
        }
    
        // Действие кнопки "Зарегистрируйтесь"
        @objc func letRegisterButtonTapped() {
            coordinator?.showThirdScreen()  // пока стоит заглушка
        }
    
    
        // метод показа клавиатуры и подъёма экрана наверх
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
            }

            func showDocumentNumberTextField() {
                phoneTextField.isHidden = true
                documentNumberTextField.isHidden = false
            }

}



// MARK: скрытие клавиатуры по нажатию на return
extension SecondViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
