//
//  CoordinatorTransitionType.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

typealias TransitionCompletion = ((Bool) -> Void)


/**
 the transition performs 
 
 
 */
protocol TransitionType {
    associatedtype SourceViewController: UIViewController
    associatedtype DestinationViewController: UIViewController
    
    func perform(for destination: DestinationViewController, from sourceViewController: SourceViewController, animated: Bool, completion: @escaping TransitionCompletion)
}

struct NavigationTransitionType<DestinationViewController: UIViewController>: TransitionType {
    typealias SourceViewController = UINavigationController
    
    func perform(for destination: DestinationViewController, from sourceViewController: SourceViewController, animated: Bool, completion: @escaping TransitionCompletion) {
        sourceViewController.pushViewController(destination, animated: animated)
    }
}

struct PresentTransitionType<SourceViewController: UIViewController, DestinationViewController: UIViewController>: TransitionType {
    
    func perform(for destination: DestinationViewController, from sourceViewController: SourceViewController, animated: Bool, completion: @escaping TransitionCompletion) {
        sourceViewController.present(destination, animated: animated) {
            completion(true)
        }
    }
}

enum CoordinatorTransition {
    case push(UINavigationController)
    case present(UIViewController)
    case windowRoot(UIWindow)
    case none
}


extension CoordinatorTransition {
    func execute(for destination: CoordinatorType){
        let rootDestination = destination.rootViewController
        
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
