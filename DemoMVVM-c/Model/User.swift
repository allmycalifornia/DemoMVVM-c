//
//  User.swift
//  DemoMVVM-c
//
//  Created by Борис Кравченко on 01.11.2023.
//

import Foundation

struct User {
    let phoneNumber: String
    let documentNumber: String
    let password: String
}

let users: [User] = [
    User(phoneNumber: "+79991234567", documentNumber: "12 34 567890", password: "abc123"),
    User(phoneNumber: "+79991111111", documentNumber: "11 22 333444", password: "abc123")
]



