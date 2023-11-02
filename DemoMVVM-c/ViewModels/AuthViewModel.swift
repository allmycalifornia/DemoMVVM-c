//
//  AuthViewModel.swift
//  DemoMVVM-c
//
//  Created by Борис Кравченко on 01.11.2023.
//

import Foundation

class AuthViewModel {
    weak var coordinator: AppCoordinator?
    
    func authenticateUser(phoneNumber: String, password: String, users: [User]) -> String? {
        // Проверка введенных данных

        if phoneNumber.count < 11 {
            return "Номер телефона должен содержать 11 цифр"
        }

        if password.count < 6 || password.count > 20 {
            return "Пароль должен содержать от 6 до 20 символов"
        }

        // Проверка авторизации
                if let user = users.first(where: { $0.phoneNumber == phoneNumber }) {
                    if user.password == password {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            self.coordinator?.showThirdScreen()
                                        }
                        return "Успешная авторизация. Сейчас будет выполнен вход"
                    } else {
                        return "Неверный пароль"
                    }
                } else {
                    return "Данный пользователь не найден"
        }
    }
}

