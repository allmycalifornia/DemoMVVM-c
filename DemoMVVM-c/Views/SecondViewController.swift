//
//  SecondViewController.swift
//  DemoMVVM-c
//
//  Created by Борис Кравченко on 30.10.2023.
//

import UIKit

class SecondViewController: UIViewController {
    var viewModel: SecondViewModel!
    var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        title = "Второй экран"
        
        let button = UIButton()
        button.setTitle("Переход на третий экран", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func nextButtonTapped() {
        coordinator?.showThirdScreen()
    }
}

