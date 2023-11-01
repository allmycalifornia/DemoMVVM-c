//
//  AppCoordinator.swift
//  DemoMVVM-c
//
//  Created by Борис Кравченко on 30.10.2023.
//

import UIKit

class AppCoordinator {
    let window: UIWindow
    let navigationController: UINavigationController
    let firstViewModel = FirstViewModel()
    
    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
        window.rootViewController = navigationController
    }
    
    func start() {
        let firstViewController = FirstViewController()
        firstViewController.viewModel = firstViewModel
        firstViewController.coordinator = self
        navigationController.pushViewController(firstViewController, animated: false)
    }
    
    func showSecondScreen() {
        let secondViewModel = AuthViewModel()
        let secondViewController = SecondViewController()
        secondViewController.viewModel = secondViewModel
        secondViewController.coordinator = self
        navigationController.pushViewController(secondViewController, animated: true)
    }

    
    func showThirdScreen() {
        let thirdViewModel = ThirdViewModel()
        let thirdViewController = ThirdViewController()
        thirdViewController.viewModel = thirdViewModel
        thirdViewController.coordinator = self
        navigationController.pushViewController(thirdViewController, animated: true)
    }
}

