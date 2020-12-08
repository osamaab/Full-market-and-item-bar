//
//  AppDelegate.swift
//  talabyeh
//
//  Created by loai elayan on 10/4/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import LanguageManager_iOS
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var shared: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    var currentCoordinator: CoordinatorType?
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupServices()
        setupApperance()
        
        
        let marketCoordinator = MarketCoordinator()
        
        let distributersCoordinator = DistributersListCoordinator()
        
        let cartCoordinator = CartCoordinator()
        
        let favoritesCoordinator = FavoritesCoordinator()
        
        let profileCoordinator = ProfileCoordinator()
        
        let componentsLab = ComponentsLabCoordinator()
        
        let tabBarCoordinator = TabBarCoordinator(coordinators: [marketCoordinator, componentsLab, distributersCoordinator, favoritesCoordinator, profileCoordinator, cartCoordinator])
        
        self.currentCoordinator = tabBarCoordinator
        tabBarCoordinator.start(with: .windowRoot(self.window!))
        
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

