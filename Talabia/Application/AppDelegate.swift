//
//  AppDelegate.swift
//  talabyeh
//
//  Created by loai elayan on 10/4/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import LanguageManager_iOS
import IQKeyboardManager
import XCoordinator
import Resolver

typealias AppRouter = UnownedRouter<AppRoutes>

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var shared: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    @Injected var appSetupHandler: AppSetupStepType
     
    lazy var mainWindow = UIWindow()
    lazy var coordinator = AppCoordinator()

    var router: AppRouter {
        coordinator.unownedRouter
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Resolver.register {
            self.coordinator.unownedRouter
        }

        appSetupHandler.setup(for: application, delegate: self, launchOptions: launchOptions)
        coordinator.setRoot(for: mainWindow)
                
        return true
    }
}

