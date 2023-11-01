//
//  AuthViewModel.swift
//  DemoMVVM-c
//
//  Created by Борис Кравченко on 01.11.2023.
//

import Foundation

class AuthViewModel {
    func authenticateUser(phoneNumber: String, password: String, users: [User]) -> String? {
        // Проверка введенных данных

        if phoneNumber.count < 11 {
            return "Номер телефона должен содержать минимум 11 цифр"
        }

        if password.count < 6 || password.count > 20 {
            return "Пароль должен содержать от 6 до 20 символов"
        }

        // Проверка авторизации
        if let user = users.first(where: { $0.phoneNumber == phoneNumber }) {
            if user.password == password {
                return "Авторизация успешна"
            } else {
                return "Неверный пароль"
            }
        } else {
            return "Данный пользователь не найден"
        }
    }
}

