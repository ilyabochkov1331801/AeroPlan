//
//  AlertCoordinator.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.04.21.
//

import UIKit

final class AlertCoordinator {
    static let shared: AlertCoordinator = AlertCoordinator()
    
    func showAlert(with title: String, message: String) {
        let alert = OverlayAlertController(title: title, message: message)
        let action = makeAlertAction(for: .close) { [weak alert] in alert?.hide() }
        alert.addAction(action)
        alert.show()
    }
    
    func showError(error: AppError) {
        showAlert(with: "Error", message: error.description)
    }
}

private extension AlertCoordinator {
    enum ActionType {
        case close
        
        var title: String {
            switch self {
            case .close: return "Close"
            }
        }
        
        var style: UIAlertAction.Style {
            switch self {
            case .close: return .default
            }
        }
    }
    
    func makeAlertAction(for type: ActionType, handler: @escaping () -> Void) -> UIAlertAction {
        UIAlertAction(title: type.title, style: type.style) { _ in handler() }
    }
}
