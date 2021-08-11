//
//  LaunchScreen.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import UIKit

final class LaunchScreen: Screen<LaunchTransitions, LaunchViewModel> {
    private let label = UILabel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.launchApplication()
    }
    
    override func arrangeView() {
        super.arrangeView()
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func setupView() {
        super.setupView()
        
        label.text = "Launch"
    }
    
    override func setupBinding() {
        super.setupBinding()
    }
}
