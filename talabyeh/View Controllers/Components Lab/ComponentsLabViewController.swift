//
//  ComponentsLabViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 01/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class ComponentsLabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.background1
        
        let button = BorderedButton()
        button.setTitle("Checkout", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = .init(top: 5, left: 20, bottom: 5, right: 20)
        
        view.addSubview(button)
        button.centerInContainer()
        
        button.addAction {
            self.navigationController?.pushViewController(CLLabViewController(), animated: true)
        }
    }
}

