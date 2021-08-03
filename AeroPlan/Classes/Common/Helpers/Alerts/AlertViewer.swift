//
//  AlertViewer.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.04.21.
//

protocol ErrorHandler {
    func showError(_ error: AppError)
}

protocol MessagesHandler {
    func showMessage(title: String, body: String)
}

protocol EventsHandler: ErrorHandler, MessagesHandler { }

extension MessagesHandler {
    private var alertCoordinator: AlertCoordinator { .shared }
    
    func showMessage(title: String, body: String) {
        alertCoordinator.showAlert(with: title, message: body)
    }
}

extension ErrorHandler {
    private var alertCoordinator: AlertCoordinator { .shared }
    
    func showError(_ error: AppError) {
        alertCoordinator.showError(error: error)
    }
}
