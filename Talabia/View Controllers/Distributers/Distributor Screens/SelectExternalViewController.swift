//
//  SelectExternalViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 22/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class SelectExternalViewController: SelectDistributorViewController {    
    init(){
        super.init(listType: .external)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
