//
//  LaunchScreen.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 30.04.21.
//

import UIKit

final class LaunchScreen: Screen<LaunchViewModel> {
    private let label = UILabel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.transitions.openAutorizationFlow?()
    }
    
    override func arrangeView() {
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func setupView() {
        label.text = "Launch"
    }
}
