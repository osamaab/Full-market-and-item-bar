//
//  CoordinatorTransitionType.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

enum CoordinatorTransition {
    case push(UINavigationController)
    case present(UIViewController)
    case windowRoot(UIWindow)
    case none
}


extension CoordinatorTransition {
    func execute(for destination: CoordinatorType){
        guard let rootDestination = destination.rootViewController else {
            return
        }
        
        switch self {
        case .present(let viewController):
            viewController.present(rootDestination, animated: true, completion: nil)
        case .push(let navigationController):
            navigationController.pushViewController(rootDestination, animated: true)
        case .windowRoot(let window):
            window.rootViewController = rootDestination
            window.makeKeyAndVisible()
        case .none:
            break
        }
    }
}

extension CoordinatorType {
    func start(with transition: CoordinatorTransition) {
        prepareToStart()
        transition.execute(for: self)
    }
}
