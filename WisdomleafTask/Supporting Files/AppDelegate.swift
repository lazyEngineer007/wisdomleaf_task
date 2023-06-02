//
//  AppDelegate.swift
//  WisdomleafTask
//
//  Created by Ajeeth Kumar on 01/06/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // Transition to the main interface
            // For example:
           // self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }

        return true
    }

    


}

