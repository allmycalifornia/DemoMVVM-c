//
//  InputState.swift
//  DemoMVVM-c
//
//  Created by Борис Кравченко on 02.11.2023.
//

import Foundation
import Combine

class InputState {
    var phoneNumberValid = PassthroughSubject<Bool, Never>()
    var passwordValid = PassthroughSubject<Bool, Never>()
}

