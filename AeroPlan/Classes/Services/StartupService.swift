//
//  StartupService.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.04.21.
//

import Firebase

final class StartupService {
    func configureEnvironment(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        FirebaseApp.configure()
    }
}
