//
//  CompanyProductDetailsViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 24/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

protocol ProductDetailsViewControllerDelegate: AnyObject {
    func ProductDetailsViewControllerDidTapAdd(_ sender: ProductDetailsViewController, didFinishWith product: Product)
}

class ProductDetailsViewController: UIViewController {
    
    let scrollView: ScrollContainerView
    let contentView: ProductDetailsContentView
    let product: Product
    var isSelected: Bool?
    
    weak var delegate: ProductDetailsViewControllerDelegate?
    
    @Injected var cartManager: CartManagerType
    @Injected var preferencesManager: DefaultPreferencesController
    
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
        title = "Product details"
        addBackButton()
    
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.addSubview(scrollView)
        scrollView.fillContainer()
        
        
        
        contentView.headerView.topLabel.text = "KG" //product.unit.title
        contentView.headerView.titleLabel.text = "\(product.item?.name ?? "")-(\(product.price ?? 0))KG"
        contentView.headerView.companyTitleLabel.text = "\(product.username ?? "Osama.Co")"
        contentView.headerView.subtitleLabel1.text = "JD \(String(describing: product.price ?? 0))"
        contentView.descriptionLabel.text = product.description
        
//        contentView.headerView.imageView.sd_setImage(with: product.images.first?.url, completed: nil)
        contentView.headerView.imageView.image = UIImage(named: "tomato")
        if let firstHistory = product.history?.first {
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
        

//        contentView.actionButton.setTitle("Add to Cart", for: .normal)
        contentView.alternativeButton.setTitle("Buy Now", for: .normal)
        
        contentView.actionButton.add(event: .touchUpInside) { [weak self] in
            guard let self = self else { return }
            if self.isSelected == true {
                self.attemptToRemoveProduct(self.product)
                self.isSelected = !self.isSelected!
            }else {
                self.attemptToAddProduct(self.product)
                self.isSelected = !self.isSelected!
//                MarketAPI.companyMarket(self.product.companyId).request(Market.self)
                self.delegate?.ProductDetailsViewControllerDidTapAdd(self, didFinishWith: self.product)
                self.anmation()
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        if preferencesManager.currentCart?.products.count == 0 {
            cartManager.clearCart()
        }
        let items = preferencesManager.currentCart?.products.contains(CartItem(product: self.product, quantity: self.contentView.quantityView.value))
        if items ?? false {
            removeButton()
            isSelected = true
        }else{
            addButton()
            isSelected = false
    }
    }
    func removeButton(){
        contentView.actionButton.setTitle("Remove from the Cart", for: .normal)
    }
    func addButton(){
        contentView.actionButton.setTitle("Add to Cart", for: .normal)
    }
    private func anmation() {
        let imageV = contentView.headerView.imageView
        let originalTransform = imageV.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.2, y: 0.2)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: -500, y: 4700)
        UIView.animate(withDuration: 1.2) {
            imageV.transform = scaledAndTranslatedTransform
        } completion: { _ in
            imageV.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                imageV.image = UIImage(named: "tomato")
                imageV.transform = .identity

            }, completion: nil)
        }

    }
    
    func attemptToAddProduct(_ product: Product){
        do {
            try cartManager.add(product: self.product, for: self.contentView.quantityView.value)
            self.showMessage(message: "Product added successfuly", messageType: .success)
            self.removeButton()
            updateBadgeValue()
        } catch let error as CartManagerError {
            switch error {
            case .differentCompany:
                self.showMessage(message: "Product belongs to different company than the one in your cart, cart will be cleared.", messageType: .failure)
                self.cartManager.clearCart()
                self.attemptToAddProduct(product)
                break
            case .alreadyExists:
                self.showMessage(message: "Product Already Exists", messageType: .failure)
                self.removeButton()
            }
        } catch {
            self.showMessage(message: error.localizedDescription, messageType: .failure)
        }
    }
    func attemptToRemoveProduct(_ product: Product){
             cartManager.remove(product: self.product)
        updateBadgeValue()
            self.showMessage(message: "Product removed successfuly", messageType: .success)
            self.addButton()
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
     func updateBadgeValue() {
        if let tabItems = self.tabBarController?.tabBar.items {
        let tabItem = tabItems[1]
        tabItem.badgeValue = "\(self.cartManager.orderedItems().count)"
    }
    
}
}


extension UIView {

    var snapshot: UIImage {
        return UIGraphicsImageRenderer(size: bounds.size).image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }

}
