//
//  CartManagerType.swift
//  talabyeh
//
//  Created by Hussein Work on 28/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct CartContents: Codable {
    let products: [CartItem]
    let companyUsername: String
}


struct CartItem: Hashable, Comparable {
    static func < (lhs: CartItem, rhs: CartItem) -> Bool {
        lhs.product.id < rhs.product.id
    }
    
    let product: Product
    let quantity: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(product.id)
        hasher.combine(quantity)
    }
}

extension CartItem: Codable { }

enum CartManagerError: Error {
    case differentCompany
    case alreadyExists
}

protocol CartManagerType: AnyObject {
    
    
    /**
     Adds the product to the cart
     */
    func add(product: Product, for quantity: Int) throws
    
    
    /**
     Deletes the product from the store
     */
    func remove(product: Product)
    
    
    /**
     The default implementation removes the product and re-adds it again
     */
    func set(quantity: Int, for product: Product)
    
    
    /**
     Returns the items of the cart ordered
     */
    func orderedItems() -> [CartItem]
        
    /**
     Clears the cart from the products
     */
    func clearCart()
}

extension CartManagerType {
    func totalPrice() -> Double {
        let products = orderedItems()
        
        return products.reduce(0, { (result, item) in
            return result + (item.product.price ?? 0) * Double(item.quantity)
        })
    }
    
    func contents() -> CartContents? {
        return .init(products: orderedItems(), companyUsername: "__hussein")
    }
    
    func set(quantity: Int, for product: Product){
        do {
            self.remove(product: product)
            
            if quantity != 0 {
                try self.add(product: product, for: quantity)
            }
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
        self.products = Set(preferencesManager.currentCart?.products ?? [])
        self.currentCompanyUsername = preferencesManager.currentCart?.companyUsername
    }
    
    func add(product: Product, for quantity: Int) throws {
        print("Attempting to insert a new product..")
        
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
            saveCart()
        }
        
        saveCart()
    }
    
    func saveCart(){
        UserDefaultsPreferencesManager.shared.currentCart = CartContents(products: orderedItems(), companyUsername: "__hussein")

    }
    
    func clearCart() {
        self.currentCompanyUsername = nil
        self.products = nil
        saveCart()
        
    }
    
    func orderedItems() -> [CartItem] {
        self.products?.sorted(by: { $0.quantity > $1.quantity }) ?? []
    }
}


class AnotherCartManagerType: CartManagerType {
    
    @Injected var preferencesManager: DefaultPreferencesController
    
    fileprivate var currentCompanyUsername: String?
    fileprivate var items: [CartItem] = []
    
    init(){
        self.currentCompanyUsername = preferencesManager.currentCart?.companyUsername
        self.items = preferencesManager.currentCart?.products ?? []
    }
    
    func add(product: Product, for quantity: Int) throws {
        guard self.currentCompanyUsername != nil else {
            self.items = []
            self.currentCompanyUsername = product.username
            
            self.items.append(.init(product: product, quantity: quantity))
            self.saveCart()
            return
        }
        
        if product.username == currentCompanyUsername {
            if !(items.contains { $0.product.id == product.id }) {
                self.items.append(.init(product: product, quantity: quantity))
            } else {
                throw CartManagerError.alreadyExists
            }
            
        } else {
            throw CartManagerError.differentCompany
        }
        
        
        // now, we want to save..
        self.saveCart()
    }
    
    func remove(product: Product) {
        if let index = (self.items.firstIndex { $0.product.id == product.id }) {
            self.items.remove(at: index)
            saveCart()
        }
        
        saveCart()
    }
    
    func saveCart(){
        UserDefaultsPreferencesManager.shared.currentCart = CartContents(products: orderedItems(), companyUsername: "__hussein")

    }
    
    func clearCart() {
        self.currentCompanyUsername = nil
        self.items = []
        saveCart()
    }
    
    func orderedItems() -> [CartItem] {
        items
    }
    
    func set(quantity: Int, for product: Product) {
        if let index = (self.items.firstIndex { $0.product.id == product.id }) {
            self.items.remove(at: index)
            saveCart()
            if quantity != 0 {
                self.items.insert(.init(product: product, quantity: quantity), at: index)
                saveCart()
            }
           
        }
    }
}
