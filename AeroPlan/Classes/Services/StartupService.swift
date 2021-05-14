//
//  StartupService.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.04.21.
//

import Firebase
import GoogleSignIn

final class StartupService {
    func configureEnvironment(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = Configuration.global.googleClientId
    }
}
