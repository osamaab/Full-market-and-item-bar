//
//  ChangePasswordCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 15/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import XCoordinator
import Promises

enum ChangePasswordRoute: Route {
    case changePassword
}

class ChangePasswordCoordinator: NavigationCoordinator<ChangePasswordRoute> {
    
    init(){
        super.init(rootViewController: NavigationController(style: .secondary, autoShowsCloseButton: true), initialRoute: .changePassword)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .changePassword:
            let vc = ChangePasswordViewController()
            vc.delegate = self
            return .push(vc)
        }
    }
}

extension ChangePasswordCoordinator: ChangePasswordViewControllerDelegate {
    func changePasswordViewController(_ sender: ChangePasswordViewController, didFinishWith output: ChangePasswordViewController.Output) {
        
        self.rootViewController.performTask(taskOperation: ProfileAPI.changePassword(output.oldPassword, output.newPassword).request(String.self)).then {
            
            self.rootViewController.showMessage(message: $0, messageType: .success)
            self.performTransition(.dismiss(), with: .init(animated: true))
        }
    }
}
