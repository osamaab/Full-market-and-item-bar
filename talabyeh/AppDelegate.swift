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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var shared: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
        
    lazy var mainWindow = UIWindow()
    lazy var router = AppCoordinator().strongRouter


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupServices()
        setupApperance()
        
        router.setRoot(for: mainWindow)
        return true
    }
}

extension AppDelegate {
    func setupServices(){
        LanguageManager.shared.defaultLanguage = .en
        IQKeyboardManager.shared().isEnabled = true
    }
    
    func setupApperance(){
    }
}

