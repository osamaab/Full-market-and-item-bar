//
//  contactUsCoordinators.swift
//  Talabia
//
//  Created by Osama Abu hdba on 04/05/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import XCoordinator
import Promises

enum ContactUsdRoute: Route {
    case contactUs
}

class ContactUsCoordinator: NavigationCoordinator<ContactUsdRoute> {
    
    init(){
        super.init(rootViewController: NavigationController(style: .primary, autoShowsCloseButton: true), initialRoute: .contactUs)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .contactUs:
            let vc = ContactDesignersViewController()
            return .push(vc)
        }
    }
}

//extension ContactUsCoordinator: ChangePasswordViewControllerDelegate {
//    func changePasswordViewController(_ sender: ChangePasswordViewController, didFinishWith output: ChangePasswordViewController.Output) {
//
//        self.rootViewController.performTask(taskOperation: ProfileAPI.changePassword(output.oldPassword, output.newPassword).request(String.self)).then {
//
//            self.rootViewController.showMessage(message: $0, messageType: .success)
//            self.performTransition(.dismiss(), with: .init(animated: true))
//        }
//    }
//}
