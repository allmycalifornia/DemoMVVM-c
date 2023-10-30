//
//  ThirdViewController.swift
//  DemoMVVM-c
//
//  Created by Борис Кравченко on 30.10.2023.
//

import UIKit
import SnapKit

class ThirdViewController: UIViewController {
    var viewModel: ThirdViewModel!
    var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        
        let label = UILabel()
        label.text = "Третий экран"
        
        view.addSubview(label)
    
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}

