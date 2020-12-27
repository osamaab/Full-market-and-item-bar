//
//  OperationDetailsViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 13/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class OperationDetailsViewController: UIViewController {
    
    lazy var operationView: BaseOprationCollectionViewCell = PendingOperationCollectionViewCell()
    lazy var checkDistributerAccessoryView = CheckDistributersOperationAccessoryView()
    lazy var clientPreferAccessoryView = ClientPreferOperationAccessoryView()
    
    lazy var operationDetailsView = OperationDetailsContentView(operationDetailsView: operationView, accessoryViews: [checkDistributerAccessoryView, clientPreferAccessoryView])

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        view.addSubview(operationDetailsView)
        operationDetailsView.translatesAutoresizingMaskIntoConstraints = false
        
        operationDetailsView.leading(0).trailing(0)
        operationDetailsView.Top == view.safeAreaLayoutGuide.Top
        operationDetailsView.Bottom == view.safeAreaLayoutGuide.Bottom
        
        (0...10).map { "Cat No. \($0)" }.reversed().forEach {
            operationDetailsView.insert(text: $0, for: "Catssssss")
        }
    }
}
