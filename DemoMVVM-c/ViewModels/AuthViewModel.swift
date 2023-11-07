//
//  AuthViewModel.swift
//  DemoMVVM-c
//
//  Created by Борис Кравченко on 01.11.2023.
//

import Foundation

class AuthViewModel {
    weak var coordinator: AppCoordinator?
    
    func authenticateUser(phoneNumber: String, documentNumber: String, password: String, users: [User]) -> String? {

        // Проверка авторизации
            if let user = users.first(where: { $0.phoneNumber == phoneNumber || $0.documentNumber == documentNumber }) {
                    if user.password == password {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            self.coordinator?.showThirdScreen()
                                        }
                        return TextLabels.LoginVC.autorizationSuccess
                    } else {
                        return TextLabels.LoginVC.wrongPassword
                    }
                } else {
                    return TextLabels.LoginVC.wrongPhone
        }
    }
}
