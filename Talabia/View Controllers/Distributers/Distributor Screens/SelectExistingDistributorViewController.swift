//
//  SelectExistingDistributorViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 22/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class SelectExistingDistributorViewController: SelectDistributorViewController {
    init(){
        super.init(listType: .existing)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
