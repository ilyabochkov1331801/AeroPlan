//
//  ModalWindowViewController.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.04.21.
//

import UIKit

open class ModalWindowViewController: UIViewController {
    private var containerWindow: UIWindow?
    
    open override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    open func show(animated: Bool = true) {

        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .fullScreen

        containerWindow = UIWindow(frame: UIScreen.main.bounds)
        containerWindow?.rootViewController = UIViewController()
        containerWindow?.windowLevel = (UIApplication.shared.windows.last?.windowLevel ?? UIWindow.Level.alert) + 1
        containerWindow?.makeKeyAndVisible()
        containerWindow?.rootViewController?.present(self, animated: animated, completion: nil)
    }

    open func hide(animated: Bool = true) {
        dismiss(animated: animated)
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        containerWindow?.isHidden = true
        containerWindow = nil
    }
}
