//
//  ProductDetailsViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 24/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    let scrollView: ScrollContainerView
    let contentView: ProductDetailsContentView
    
    init(){
        self.contentView = .init()
        self.scrollView = .init(contentView: contentView)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.addSubview(scrollView)
        scrollView.fillContainer()
        
        
        
        contentView.descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        contentView.additionalDetailsLabel.text = "Production Date\n22/3/2021\n\nExp. Date\n22/3/2022"

        contentView.actionButton.setTitle("Add to cart", for: .normal)
        contentView.alternativeButton.setTitle("Buy Now", for: .normal)
        
        contentView.headerView.imageView.image = UIImage(named: "Rectangle 232")
        contentView.headerView.subtitleLabel1.text = "Red Onions"
        contentView.headerView.titleLabel.text = "New era market"
        contentView.headerView.subtitleLabel2.text = "JD 0.200"
    }
}
