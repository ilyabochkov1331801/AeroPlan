//
//  OverlayAlertController.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.04.21.
//

import SnapKit
import UIKit

final class OverlayAlertController: ModalWindowViewController {
    public let alertController: UIAlertController

    public init(title: String?, message: String?) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(alertController)
        alertController.didMove(toParent: self)

        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(alertController.view)

        alertController.view.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    func addAction(_ action: UIAlertAction) {
        alertController.addAction(action)
    }
}
