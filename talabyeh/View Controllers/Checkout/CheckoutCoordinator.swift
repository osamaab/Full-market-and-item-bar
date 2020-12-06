//
//  CheckoutCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 02/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class CheckoutCoordinator: NSObject, CoordinatorType {
    
    var rootViewController: UIViewController {
        checkoutViewController
    }
    
    let checkoutViewController: CheckoutViewController
    
    override init(){
        self.checkoutViewController = .init()
        super.init()
    }
}
