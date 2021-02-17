//
//  ResellerStoreLocationsCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 15/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import XCoordinator
import Promises

class ResellerStoreLocationsCoordinator: StoreLocationsCoordinator {
    
    let reseller: Reseller
    
    init(reseller: Reseller){
        self.reseller = reseller
        super.init()
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .new:
            let newVC = ResellerNewStoreLocationViewController()
            newVC.delegate = self
            return .push(newVC)
        case .edit(let location):
            let editVC = ResellerEditStoreLocationViewController(storeLocation: location)
            editVC.delegate = self
            return .push(editVC)        default:
            return super.prepareTransition(for: route)
        }
    }
}

extension ResellerStoreLocationsCoordinator: ResellerNewStoreLocationViewControllerDelegate {
    func resellerNewStoreLocationViewController(_ sender: ResellerNewStoreLocationViewController, didFinishWith location: NewStoreLocation) {
        
        let task: Promise<String>
        if let _ = sender as? ResellerEditStoreLocationViewController {
            task = StoreLocationsAPI.edit(location).request(String.self)
        } else {
            task = StoreLocationsAPI.new(location).request(String.self)
        }
        
        sender.performTask(taskOperation: task).then {
            self.rootViewController.showMessage(message: $0, messageType: .success)
            self.rootViewController.popViewController(animated: true)
        }
    }
}
