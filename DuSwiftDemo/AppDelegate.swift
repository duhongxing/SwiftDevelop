//
//  AppDelegate.swift
//  DuSwiftDemo
//
//  Created by 杜红星 on 2024/10/25.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        _ = DuMetricKitManager.shared
        
        setupWindow()
        
    
        return true
    }
    
    func setupWindow() {
        let vc = ViewController()
        vc.title = "ViewController"
        let navigationController = UINavigationController(rootViewController: vc)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }


}

