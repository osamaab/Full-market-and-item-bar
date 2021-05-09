//
//  ContactDesignersViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 15/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia


class ContactDesignersViewController: UIViewController {
    
    let contentView = ContactFormView()
    lazy var bottomView: BottomNextButtonView = .init(title: "Send")

    override func viewDidLoad() {
        title = "contact us"
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), action: {            self.navigationController?.popViewController(animated: true)
        })
        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            contentView
            bottomView
        }
        
        contentView.leading(10).trailing(10)
        contentView.height(100%)
        contentView.Top == view.safeAreaLayoutGuide.Top + 20
        contentView.Bottom == bottomView.Top - 20
        bottomView.leading(0).trailing(0).bottom(0)
    }
}
