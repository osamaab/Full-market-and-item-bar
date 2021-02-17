//
//  CompanyBranchesCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 14/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator
import Promises

class CompanyBranchesCoordinator: StoreLocationsCoordinator {
    
    let company: Company
    
    init(company: Company){
        self.company = company
        super.init()
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .new:
            let newVC = CompanyNewStoreLocationViewController()
            newVC.delegate = self
            return .push(newVC)
        case .edit(let location):
            let editVC = CompanyEditStoreLocationViewController(storeLocation: location)
            editVC.delegate = self
            return .push(editVC)
        default:
            return super.prepareTransition(for: route)
        }
    }
}

extension CompanyBranchesCoordinator: CompanyNewStoreLocationViewControllerDelegate {
    func companyNewStoreLocationViewController(_ sender: CompanyNewStoreLocationViewController, didFinishWith location: NewStoreLocation) {
        
        
        let task: Promise<String>
        if let _ = sender as? CompanyEditStoreLocationViewController {
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
