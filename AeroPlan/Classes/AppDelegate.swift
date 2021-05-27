//
//  AppDelegate.swift
//  AeroPlan
//
//  Created by Alena Nesterkina on 25.04.21.
//

import GoogleSignIn
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var rootCoordinator: RootCoordinator!
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        rootCoordinator = CoordinatorsBuilder.makeRootCoordinator()
        
        configureServices(launchOptions: launchOptions)
        configureAppearence()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        rootCoordinator.start(at: window)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
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
    
    func configureAppearence() {
        UITextView.appearance().linkTextAttributes = .make(font: AppFonts.Appearence.textViewLink, color: AppColors.Appearence.textViewLink)
            .merge(with: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        UITextField.appearance().defaultTextAttributes = .make(font: AppFonts.Appearence.textField, color: AppColors.Appearence.textFiled)
    }
}
