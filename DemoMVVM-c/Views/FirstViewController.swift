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
        
        let label = UILabel()
        label.text = "Первый экран"
        
        let button = UIButton()
        button.setTitle("Переход на второй экран", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        view.addSubview(label)
        view.addSubview(button)
        
        // Используйте SnapKit для установки констрейнтов
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func nextButtonTapped() {
        coordinator?.showSecondScreen()
    }

}

