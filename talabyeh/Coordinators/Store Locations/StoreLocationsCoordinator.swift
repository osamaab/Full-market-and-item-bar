//
//  StoreLocationsCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 15/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import XCoordinator
import Promises

enum StoreLocationsRoute: Route {
    case list
    case new
    case edit(StoreLocation)
    case delete(StoreLocation)
    case map(StoreLocation)
}

class StoreLocationsCoordinator: NavigationCoordinator<StoreLocationsRoute> {
        
    init(){
        super.init(rootViewController: NavigationController(style: .secondary, autoShowsCloseButton: true), initialRoute: .list)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .list:
            return .push(StoreLocationListViewController(router: self.unownedRouter))
        case .new:
            fatalError("Subclasses should implementn this")
        case .edit:
            fatalError("Subclasses should implement this")
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
