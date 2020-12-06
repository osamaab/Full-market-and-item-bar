//
//  AuthenticationCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit


class AuthenticationCoordinator: CoordinatorType {
    
    var rootViewController: UIViewController {
        navigationController
    }
    
    let storyboard: UIStoryboard
    let navigationController: UINavigationController
    
    init(){
        self.storyboard = .init(name: "Authentication", bundle: nil)
        self.navigationController = self.storyboard.instantiateInitialViewController() as! UINavigationController
    }
    
    func start() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = self.rootViewController
        appDelegate.window?.makeKeyAndVisible()
    }
}
 
