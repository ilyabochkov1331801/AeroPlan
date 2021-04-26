//
//  AppDelegate.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 25.04.21.
//

import Firebase
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
