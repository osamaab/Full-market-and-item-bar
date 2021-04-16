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
        title = "\(String(describing: product.item.name))"
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"search-Icon"), action: {})
        addBackButton()
    
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.addSubview(scrollView)
        scrollView.fillContainer()
        
        
        
        contentView.headerView.topLabel.text = "KG" //product.unit.title
        contentView.headerView.titleLabel.text = "\(product.item.name)-\(product.price)KG"
        contentView.headerView.subtitleLabel1.text = "JD \(product.price)"
        contentView.descriptionLabel.text = product.description
        
//        contentView.headerView.imageView.sd_setImage(with: product.images.first?.url, completed: nil)
        contentView.headerView.imageView.image = UIImage(named: "tomato")
        if let firstHistory = product.history.first {
            contentView.additionalDetailsLabel.text = "Production Date\n\(firstHistory.productionDate)\n\nExp. Date\n\(firstHistory.expirationDate)"
            let attrString = NSMutableAttributedString(string: contentView.additionalDetailsLabel.text ?? "")
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 2
            style.alignment = .center
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: contentView.additionalDetailsLabel.text?.count ?? 0))
            attrString.addAttribute(NSAttributedString.Key.kern, value: 0, range: NSMakeRange(0, attrString.length))
            contentView.additionalDetailsLabel.attributedText = attrString
        }
        
        contentView.descriptionLabel.text = product.description
        

        contentView.actionButton.setTitle("Add to Cart", for: .normal)
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
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    @objc func backAction(_ sender: UIButton) {
        let _ = navigationController?.popViewController(animated: true)
    }
}
