//
//  AppDelegate.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 25.04.21.
//

import GoogleSignIn
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var rootCoordinator: RootCoordinator!
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        rootCoordinator = CoordinatorsBuilder.makeRootCoordinator()
        
        configureServices(launchOptions: launchOptions)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        rootCoordinator.start(at: window)
        
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        GIDSignIn.sharedInstance().handle(url)
    }
}

private extension AppDelegate {
    var startupService: StartupService {
        rootCoordinator.startupService
    }
    
    func configureServices(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        startupService.configureEnvironment(launchOptions: launchOptions)
    }
}
