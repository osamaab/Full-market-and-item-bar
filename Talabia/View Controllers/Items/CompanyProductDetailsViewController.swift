//
//  CompanyProductDetailsViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 22/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

class CompanyProductDetailsViewController: ContentViewController<Product> {

    lazy var scrollView: ScrollContainerView = .init(contentView: contentView)
    lazy var contentView: CompanyProductDetailsContentView = .init()
    
    var router: UnownedRouter<ItemsRoute>
    let subCategory: SubCategory
    
    init(product: Product, router: UnownedRouter<ItemsRoute>, subCategory: SubCategory){
        self.router = router
        self.subCategory = subCategory
        super.init(contentRepository: ConstantContentRepository(content: product))
    }
    
    init<R: ContentRepositoryType>(contentRepository: R, router: UnownedRouter<ItemsRoute>, subCategory: SubCategory) where R.ContentType == ContentType {
        self.router = router
        self.subCategory = subCategory
        super.init(contentRepository: contentRepository)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViewsBeforeTransitioning() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", action: {
            self.router.trigger(.newItem(self.subCategory))
        })
        addBackButton()
        title = "Product Details"
        view.addSubview(scrollView)
        scrollView.fillContainer()
    }
    
    override func contentRequestDidSuccess(with content: Product) {
        let product = content
        
        contentView.topLabel.text = "KG"//product.unit.title
        contentView.titleLabel.text = "\(product.item?.name ?? "")-\(product.totalQuantity ?? 0)KG" 
        contentView.priceLabel.text = "JD \(product.price ?? 0.0)"
        contentView.descriptionLabel.text = product.description
        
        contentView.imageView.image = UIImage(named: "tomato")
        if let firstHistory = product.history?.first {
            contentView.productionLabel.text = "Production Date\n\(firstHistory.productionDate)"
            contentView.expirationLabel.text = "Exp. Date\n\(firstHistory.expirationDate)"
        }
        
        product.history?.forEach {
            contentView.addHistoryText("\(String(describing: product.item?.name)) - \($0.quantity)\(String(describing: product.unit?.title)) - \($0.expirationDate)")
        }
        
        contentView.newQuantityButton.add(event: .touchUpInside) {
            self.router.trigger(.newQuantity(product, self))
        }
    }
}

extension CompanyProductDetailsViewController: NewProductQuantityViewControllerDelegate {
    func newProductQuantityViewController(_ sender: NewProductQuantityViewController, didFinishWith form: NewProductQuantityViewController.NewQuantityForm) {
        
        sender.performTask(taskOperation: ItemsAPI.newQuantity(.init(userItemId: sender.product.id, quantity: form.quantity, productionDate: form.productionDate.apiFormattedDate, expirationDate: form.expirationDate.apiFormattedDate)).request(String.self)).then {
            
            sender.dismiss()
            
            self.retry()
            self.showMessage(message: $0, messageType: .success)
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
