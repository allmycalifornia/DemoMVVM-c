//
//  ItemsViewController.swift
//  DemoMVVM-c
//
//  Created by Борис Кравченко on 30.10.2023.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {
    var viewModel: FirstViewModel!
    var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "Первый экран"
        
        let button = UIButton()
        button.setTitle("Авторизоваться", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func nextButtonTapped() {
        coordinator?.showSecondScreen()
    }

}

