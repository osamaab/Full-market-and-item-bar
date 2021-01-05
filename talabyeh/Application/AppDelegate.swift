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
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var shared: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
        
    lazy var appSetupHandler: AppSetupStepType = DefaultSetupSteps.allSetupSteps()
    lazy var mainWindow = UIWindow()
    lazy var router = AppCoordinator().strongRouter


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        appSetupHandler.setup(for: application, delegate: self, launchOptions: launchOptions)
        router.setRoot(for: mainWindow)
        
        return true
    }
}

