//
//  ItemsCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 02/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

enum ItemsRoute: Route {
    case notLogin
    case allCategories
    case subCategory(MainCategory)
    
    case userCategories
    case items(SubCategory)
    case details(Product, SubCategory)
    
    case newItem(SubCategory)
    case remove(Product)
    
    case newQuantity(Product, NewProductQuantityViewControllerDelegate)
}

class ItemsCoordinator: NavigationCoordinator<ItemsRoute> {
    let authenticationManager = DefaultAuthenticationManager.shared
    let preferencesManager = UserDefaultsPreferencesManager.shared
    init(rootViewController: UINavigationController){
        super.init(rootViewController: rootViewController, initialRoute: .userCategories)
        rootViewController.tabBarItem = .items
    }
    
    init(){
        guard self.authenticationManager.isAuthenticated else {
            super.init(rootViewController: NavigationController(), initialRoute:.notLogin )
            rootViewController.tabBarItem = .items
            return
        }
        
        super.init(rootViewController: NavigationController(), initialRoute: .userCategories)
        rootViewController.tabBarItem = .items
    }

    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .notLogin:
            let vc = chooseSigninOrSignUpViewController
                { method in
                    switch method {
                    case .signUp:
                        self.preferencesManager.didTappedSignUp = true
                        AppDelegate.shared.router.trigger(.chooseUserType, completion: nil)
                        break
                    
                    case .signIn:
                        AppDelegate.shared.router.trigger(.authentication(.signin), completion: nil)
                        break
                    }
                }
            vc.title = "Items"
            return .push(vc)
        case .allCategories:
            let vc = MainCategoryViewController(router: unownedRouter.self)
            return .push(vc)
        case .subCategory(let category):
            let vc = SubCategoryViewController(router: unownedRouter.self, category: category)
            return .push(vc)
        case .userCategories:
            let viewController = ItemCategoriesViewController(router: self.unownedRouter)
            viewController.title = "Items"
            return .push(viewController)
        case .items(let subcategory):
            let viewController = ItemsViewController(router: self.unownedRouter, category: subcategory, delegate: self)
            return .push(viewController)
        case .newItem(let category):
            let viewController = NewItemViewController(category: category)
            viewController.delegate = self
            return .push(viewController)
        case .details(let product, let subCategory):
            return .push(CompanyProductDetailsViewController(product: product, router: self.unownedRouter, subCategory: subCategory))
        case .remove(let product):
            let alert = UIAlertController(title: "Delete \(product.item.name)", message: "Are you sure you want to delete this product?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
                self.performDelete(for: product)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            return .present(alert)
        case .newQuantity(let product, let delegate):
            NewProductQuantityViewController(product: product, delegate: delegate).present()
            return .none()
        }
    }
    
    fileprivate func performDelete(for product: Product){
        self.rootViewController.performTask(taskOperation: ItemsAPI.remove(product.id).request(String.self)).then {
            self.rootViewController.showMessage(message: $0, messageType: .success)
            self.rootViewController.popViewController(animated: true)
        }
    }
}

extension ItemsCoordinator: NewProductQuantityViewControllerDelegate {
    func newProductQuantityViewController(_ sender: NewProductQuantityViewController, didFinishWith form: NewProductQuantityViewController.NewQuantityForm) {

        sender.performTask(taskOperation: ItemsAPI.newQuantity(.init(userItemId: sender.product.id, quantity: form.quantity, productionDate: form.productionDate.apiFormattedDate, expirationDate: form.expirationDate.apiFormattedDate)).request(String.self)).then {

            sender.dismiss()
            self.rootViewController.showMessage(message: $0, messageType: .success)
        }
    }
}

extension ItemsCoordinator: NewItemViewControllerDelegate {
    func newItemViewController(_ sender: NewItemViewController, didFinishWith product: NewItemInput) {
        
        sender.performTask(taskOperation: ItemsAPI.new(product).request(String.self)).then { [unowned self] message in
            self.rootViewController.showMessage(message: message, messageType: .success)
            self.rootViewController.popToRootViewController(animated: true)
        }
    }
}

extension ItemsCoordinator: ItemsViewControllerDelegate {
    func authenticationCoordinator(_ sender: ItemsViewController) {
        sender.requestContent { _ in
        }
    }
    
    
}
