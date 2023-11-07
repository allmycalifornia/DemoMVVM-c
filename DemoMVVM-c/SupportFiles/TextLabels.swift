//
//  TextLabels.swift
//  DemoMVVM-c
//
//  Created by Борис Кравченко on 07.11.2023.
//

import Foundation

struct TextLabels {
    struct LoginVC {
        static var welcomeText: String {
            return NSLocalizedString("Привет!\nВойдите в Бэтта-Банк", comment: "")
        }
        static var email: String {
            return NSLocalizedString("Email", comment: "")
        }
        static var password: String {
            return NSLocalizedString("Пароль", comment: "")
        }
        static var forgotPassword: String {
            return NSLocalizedString("Забыли пароль?", comment: "")
        }
        static var next: String {
            return NSLocalizedString("Вперед", comment: "")
        }
        static var noAccount: String {
            return NSLocalizedString("У вас нет аккаунта?", comment: "")
        }
        static var register: String {
            return NSLocalizedString("Зарегистрируйтесь", comment: "")
        }
        static var phone: String {
            return NSLocalizedString("Телефон", comment: "")
        }
        static var phoneNumber: String {
            return NSLocalizedString("Номер телефона", comment: "")
        }
        static var documentNumber: String {
            return NSLocalizedString("Номер документа", comment: "")
        }
        static var document: String {
            return NSLocalizedString("Документ", comment: "")
        }
        static var emailError: String {
            return NSLocalizedString("Введен некорректный Email", comment: "")
        }
        static var documentError: String {
            return NSLocalizedString("Номер документа должен содержать 10 цифр", comment: "")
        }
        static var phoneError: String {
            return NSLocalizedString("Номер телефона должен содержать 11 цифр", comment: "")
        }
        static var passwordError: String {
            return NSLocalizedString("Пароль должен содержать от 6 до 20 символов", comment: "")
        }
        static var wrongPassword: String {
            return NSLocalizedString("Неверный пароль", comment: "")
        }
        static var wrongEmail: String {
            return NSLocalizedString("Такой Email не зарегистрирован в системе", comment: "")
        }
        static var wrongPhone: String {
            return NSLocalizedString("Данный пользователь не найден", comment: "")
        }
        static var autorizationSuccess: String {
            return NSLocalizedString("Успешная авторизация", comment: "")
        }
    }
}
    
