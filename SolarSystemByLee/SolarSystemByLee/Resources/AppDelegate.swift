//
//  AppDelegate.swift
//  SolarSystemByLee
//
//  Created by Lee McCormick on 1/7/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureNavigationBar()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func configureNavigationBar(){
        UINavigationBar.appearance().tintColor = UIColor.brown
        UINavigationBar.appearance().backgroundColor = UIColor.black
        UINavigationBar.appearance().titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: "Apple Color Emoji", size: 30)!,
             NSAttributedString.Key.foregroundColor: UIColor.brown]
    }
}
