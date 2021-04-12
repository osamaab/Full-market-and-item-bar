//
//  CompanyProductDetailsViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 22/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

class CompanyProductDetailsViewController: UIViewController {

    let scrollView: ScrollContainerView
    let contentView: CompanyProductDetailsContentView
    let product: Product

    var router: UnownedRouter<ItemsRoute>
    
    init(product: Product, router: UnownedRouter<ItemsRoute>){
        self.product = product
        self.contentView = .init()
        self.scrollView = .init(contentView: contentView)
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        view.addSubview(scrollView)
        scrollView.fillContainer()
        
        
        contentView.topLabel.text = product.unit.title
        contentView.titleLabel.text = product.item.name
        contentView.priceLabel.text = "JD \(product.price)"
        contentView.descriptionLabel.text = product.description
        
        contentView.imageView.sd_setImage(with: product.images.first?.url, completed: nil)
        
        if let firstHistory = product.history.first {
            contentView.productionLabel.text = "Production\n\(firstHistory.productionDate)"
            contentView.expirationLabel.text = "Expiration\n\(firstHistory.expirationDate)"
        }
        
        product.history.forEach {
            contentView.addHistoryText("\(product.item.name) - \($0.quantity)\(product.unit.title) - \($0.expirationDate)")
        }
        
        contentView.newQuantityButton.add(event: .touchUpInside) {
            self.router.trigger(.newQuantity(self.product))
        }
    }
}
