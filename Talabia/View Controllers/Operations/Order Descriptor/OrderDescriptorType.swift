//
//  OrderDescriptorType.swift
//  talabyeh
//
//  Created by Hussein Work on 10/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

struct Order {
    
}

protocol OrderDescriptorType {
    
    func contentRepository() -> AnyContentRepository<[Order]>
    
    func createDetailsViewController(for order: Order) -> UIViewController
}
