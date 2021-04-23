//
//  test model.swift
//  talabyeh
//
//  Created by Osama Abu hdba on 31/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct SelectedMainCategoryWithSelSuCa: Equatable, Hashable {
   

    let id: Int
    let title: String
    let logo: URL?
var subcategories = UserDefaultsPreferencesManager.shared.selectedSubCategories
    
    internal init(id: Int, title: String, logo: URL?, subcategories: [SubCategory]) {
        self.id = id
        self.title = title
        self.logo = logo
        self.subcategories = subcategories
    }
}

extension SelectedMainCategoryWithSelSuCa: Codable {
    
}
