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

enum CompanyBranchesRoute: Route {
    case list
    case new
    case edit(StoreLocation)
    case delete(StoreLocation)
    case map(StoreLocation)
}

class CompanyBranchesCoordinator: NavigationCoordinator<CompanyBranchesRoute> {
    
    let company: Company
    
    init(company: Company){
        self.company = company
        super.init(rootViewController: NavigationController(style: .secondary, autoShowsCloseButton: true), initialRoute: .list)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .list:
            return .push(CompanyStoreLocationListViewController(router: self.unownedRouter))
        case .new:
            let newVC = CompanyNewStoreLocationViewController()
            newVC.delegate = self
            return .push(newVC)
        case .edit(let location):
            let editVC = CompanyEditStoreLocationViewController(storeLocation: location)
            editVC.delegate = self
            return .push(editVC)
        case .delete(let location):
            let alert = UIAlertController(title: "Delete \(location.name)", message: "Are you sure you want to delete this location?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
                self.performDelete(for: location)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            return .present(alert)
        case .map(let location):
            let stringRaw = "https://www.google.com/maps/@\(location.lat),\(location.lng),6z"
            if let url = URL(string: stringRaw) {
                UIApplication.shared.open(url)
            } else {
                self.rootViewController.showMessage(message: "Can't open \(stringRaw)", messageType: .failure)
            }
            
            return .none()
        }
    }
    
    
    fileprivate func performDelete(for location: StoreLocation){
        
        self.rootViewController.performTask(taskOperation: StoreLocationsAPI.delete(location.id).request(String.self)).then {
            
            self.rootViewController.showMessage(message: $0, messageType: .success)
            self.rootViewController.dismiss(animated: true, completion: nil)
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
