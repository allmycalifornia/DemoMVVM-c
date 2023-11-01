//
//  User.swift
//  DemoMVVM-c
//
//  Created by Борис Кравченко on 01.11.2023.
//

import Foundation

struct User {
    let phoneNumber: String
    let password: String
}

let users: [User] = [
    User(phoneNumber: "+79991234567", password: "abc123"),
    User(phoneNumber: "+79991111111", password: "abc123")
]

