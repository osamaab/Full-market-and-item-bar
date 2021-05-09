//
//  UserModelType.swift
//  talabyeh
//
//  Created by Hussein Work on 14/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

protocol UserModelType {
    var user: User? { get }
    
    var name: String { get }
    var email: String { get }
    var mobile: String? { get }
    var imageURL: URL? { get }
    
    
    var interestCategories: [MainCategory]? { get }
    var interestSubCategories: [SubCategory]? { get }
}

extension Company: UserModelType {
    var mobile: String?{
        telephone
    }
    
    var name: String {
        title
    }
    
    var imageURL: URL? {
        URL(string: logoPath)
    }
    
    var interestCategories: [MainCategory]? {
        categories?.map { mainCat in
            let subcategoriesForMainCategory = self.subcategories?.filter { $0.categoryID == mainCat.id } ?? []
            return MainCategory(id: mainCat.id, title: mainCat.title, logo: mainCat.logo, subcategories: subcategoriesForMainCategory)
        }
    }
    
    var interestSubCategories: [SubCategory]? {
        subcategories
    }
}

extension Distributor: UserModelType {
    
    var mobile: String? {
        telephone
    }
    
    var imageURL: URL? {
        nil
    }
    
    var interestSubCategories: [SubCategory]? {
        nil
    }
    
    var interestCategories: [MainCategory]? {
        nil
    }
}

extension Reseller: UserModelType {

    var mobile: String? {
        telephone
    }
    
    var imageURL: URL? {
        nil
    }
    
    var interestSubCategories: [SubCategory]? {
        categories.reduce([]) { $0 + ($1.subcategories ?? [])  }
    }
    
    var interestCategories: [MainCategory]? {
        categories
    }
}
