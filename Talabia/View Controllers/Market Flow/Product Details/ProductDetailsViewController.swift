//
//  CompanyProductDetailsViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 24/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    let scrollView: ScrollContainerView
    let contentView: ProductDetailsContentView
    let product: Product
    
    @Injected var cartManager: CartManagerType
    
    init(product: Product){
        self.product = product
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
        
        
        contentView.headerView.topLabel.text = product.unit.title
        contentView.headerView.titleLabel.text = product.item.name
        contentView.headerView.subtitleLabel1.text = "JD\(product.price)"
        contentView.descriptionLabel.text = product.description
        
        contentView.headerView.imageView.sd_setImage(with: product.images.first?.url, completed: nil)
        
        if let firstHistory = product.history.first {
            contentView.additionalDetailsLabel.text = "Production\n\(firstHistory.productionDate)\n\nExpiration\n\(firstHistory.expirationDate)"
        }
        
        contentView.descriptionLabel.text = product.description
        

        contentView.actionButton.setTitle("Add to cart", for: .normal)
        contentView.alternativeButton.setTitle("Buy Now", for: .normal)
        
        contentView.actionButton.add(event: .touchUpInside) { [unowned self] in
            self.attemptToAddProduct(self.product)
        }
    }
    
    func attemptToAddProduct(_ product: Product){
        do {
            try cartManager.add(product: self.product, for: self.contentView.quantityView.value)
            self.showMessage(message: "Product added successfuly", messageType: .success)
        } catch let error as CartManagerError {
            switch error {
            case .differentCompany:
                self.showMessage(message: "Product belongs to different company than the one in your cart, cart will be cleared.", messageType: .failure)
                self.cartManager.clearCart()
                break
            }
        } catch {
            self.showMessage(message: error.localizedDescription, messageType: .failure)
        }
    }
}
