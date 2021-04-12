//
//  ASCompaniesViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 01/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

class ASCompaniesViewController: CompaniesViewController {

    let router: UnownedRouter<AdvancedSearchRoute>
    let name: String?
    let categoryID: Int?
    let cityID: Int?
    
    init(router: UnownedRouter<AdvancedSearchRoute>,
         name: String?,
         cityID: Int?,
         categoryID: Int?){
        self.router = router
        self.name = name
        self.categoryID = categoryID
        self.cityID = cityID
        super.init(contentRepository: APIContentRepositoryType<MarketAPI, [Company]>(.advancedSearchCompanies(categoryID, cityID, name)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
