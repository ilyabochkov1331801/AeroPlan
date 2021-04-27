//
//  AlertViewer.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.04.21.
//

protocol AlertViewer {
    var alertCoordinator: AlertCoordinator { get }
}

extension AlertViewer {
    var alertCoordinator: AlertCoordinator { .shared }
}
