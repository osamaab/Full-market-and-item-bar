//
//  CartManagerType.swift
//  talabyeh
//
//  Created by Hussein Work on 28/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct CartItem: Hashable {
    let product: Product
    let quantity: Int
}

extension CartItem: Codable { }

enum CartManagerError: Error {
    case differentCompany
}

protocol CartManagerType: class {
    
    
    /**
     Adds the product to the cart
     */
    func add(product: Product, for quantity: Int) throws
    
    
    
    func remove(product: Product)
    
    
    /**
     Clears the cart from the products
     */
    func clearCart()
    
    
    /**
     The current product list exist in the cart
     */
    var products: Set<CartItem>? { get }
}

extension CartManagerType {
    func totalPrice() -> Double {
        return products?.reduce(0, { (result, item) in
            return result + item.product.price * Double(item.quantity)
        }) ?? 0
    }
    
    func contents() -> CartContents? {
        if let products = self.products {
            return .init(products: products, companyUsername: "__hussein")
        }
        
        return nil
    }
    
    func set(quantity: Int, for product: Product){
        do {
            self.remove(product: product)
            try self.add(product: product, for: quantity)
        } catch {
            print("Can't change the quantity of the specified product")
        }
    }
}

class DefaultCartManager: CartManagerType {
    
    @Injected var preferencesManager: DefaultPreferencesController
    
    fileprivate(set) var currentCompanyUsername: String?
    fileprivate(set) var products: Set<CartItem>? = []
    
    
    init(){
        // load the current cart
        self.products = preferencesManager.currentCart?.products ?? []
        self.currentCompanyUsername = preferencesManager.currentCart?.companyUsername
    }
    
    func add(product: Product, for quantity: Int) throws {
        guard self.currentCompanyUsername != nil else {
            self.products = []
            self.currentCompanyUsername = product.username
            
            
            
            self.products?.insert(.init(product: product, quantity: quantity))
            self.saveCart()
            return
        }
        
        
        
        if product.username == currentCompanyUsername {
            self.products?.insert(.init(product: product, quantity: quantity))
        } else {
            throw CartManagerError.differentCompany
        }
        
        
        // now, we want to save..
        self.saveCart()
    }
    
    func remove(product: Product) {
        if let item = (self.products?.first { $0.product == product }) {
            self.products?.remove(item)
        }
    }
    
    func saveCart(){
        if let products = self.products {
            UserDefaultsPreferencesManager.shared.currentCart = CartContents(products: products, companyUsername: "__hussein")
        } else {
            UserDefaultsPreferencesManager.shared.currentCart = nil
        }
    }
    
    func clearCart() {
        self.currentCompanyUsername = nil
        self.products = nil
    }
}
