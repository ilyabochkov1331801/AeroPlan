//
//  AppDelegate.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 25.04.21.
//

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
}

private extension AppDelegate {
    var startupService: StartupService {
        rootCoordinator.startupService
    }
    
    func configureServices(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        startupService.configureEnvironment(launchOptions: launchOptions)
    }
}
