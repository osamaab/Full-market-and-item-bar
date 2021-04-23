//
//  DistributorsCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 02/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import XCoordinator
import Promises


enum DistributorsRoute: Route {
    case notLogin
    case home
    case profile(Distributor)
    case new
    
    case editInformation(Distributor)
    case coveringAreas(Distributor)
    case orders(Distributor)
    case status(Distributor)
    case history(Distributor)
}

class DistributorsCoordinator: NavigationCoordinator<DistributorsRoute> {
    let authenticationManager = DefaultAuthenticationManager.shared
    let preferencesManager = UserDefaultsPreferencesManager.shared
    init(){
        
        guard self.authenticationManager.isAuthenticated else {
            super.init(rootViewController: NavigationController(), initialRoute:.notLogin )
            rootViewController.tabBarItem = .distributors
            return
        }
        
        super.init(rootViewController: NavigationController(), initialRoute: .home)
        rootViewController.tabBarItem = .distributors
    }

    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .notLogin:
            let vc = chooseSigninOrSignUpViewController
                { method in
                    switch method {
                    case .signUp:
                        self.preferencesManager.didTappedSignUp = true
                        AppDelegate.shared.router.trigger(.chooseUserType, completion: nil)
                    
                        break
                    
                    case .signIn:
                        AppDelegate.shared.router.trigger(.authentication(.signin), completion: nil)
                        break
                    }
                }
            vc.title = "Distributors" 
            return .push(vc)
        case .home:
            let viewController = DistributorsListViewController(router: self.unownedRouter)
            return .push(viewController)
        case .profile(let distributor):
            return .push(CompanyDistributorProfileViewController(distributor: distributor, router: self.unownedRouter))
        case .new:
            let viewController = NewDistributorViewController()
            viewController.delegate = self
            return .push(viewController)
        case .editInformation(let distributor):
            let editVC = EditDistributorViewController(distributor: distributor)
            editVC.delegate = self
            return .push(editVC)
        case .coveringAreas(let distributor):
            let cityPicker = DistributorCoveringAreasViewController(distributor: distributor)
            cityPicker.delegate = self
            
            return .push(cityPicker)
        case .orders:
            return .none()
        case .status(let distributor):
            let statusVC = DistributorStatusViewController(distributor: distributor)
            return .push(statusVC)
        case .history(let distributor):
            let historyViewController = CompanyDistributorOrderHistoryViewController(distributor: distributor, router: self.unownedRouter)
            return .push(historyViewController)
        }
    }
}

extension DistributorsCoordinator: NewDistributerViewControllerDelegate {
    func newDistributerViewController(_ sender: NewDistributorViewController, didFinishWith form: NewDistributorInput) {
        
        let task: Promise<String>
        
        if let _ = sender as? EditDistributorViewController {
            self.rootViewController.showMessage(message: "Not supported yet", messageType: .notice)
            self.rootViewController.popViewController(animated: true)
            return
        } else {
            task = DistributorsAPI.create(form).request(String.self)
        }
        
        sender.performTask(taskOperation: task).then { [unowned self] in
            self.rootViewController.showMessage(message: $0, messageType: .success)
            self.rootViewController.popViewController(animated: true)
        }
    }
}

extension DistributorsCoordinator: CityPickerViewControllerDelegate {
    func cityPickerViewController(_ sender: CityPickerViewController, didFinishWith options: [CityItem]) {
        
        // attempt to save the covering areas..
        
        
        self.rootViewController.popViewController(animated: true)
    }
}

