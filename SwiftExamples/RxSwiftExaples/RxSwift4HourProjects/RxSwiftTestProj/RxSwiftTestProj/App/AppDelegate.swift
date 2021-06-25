//
//  AppDelegate.swift
//  RxSwiftTestProj
//
//  Created by Dannian Park on 2021/06/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let listViewController = ListViewController()
        let navigation = UINavigationController(rootViewController: listViewController)
        
        window = UIWindow()
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        return true
    }
}

