//
//  ASProductsViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 01/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

class ASProductsViewController: ProductsViewController {
    
    let router: UnownedRouter<AdvancedSearchRoute>
    let name: String?
    let categoryID: Int?
    
    init(router: UnownedRouter<AdvancedSearchRoute>,
         name: String?,
         categoryID: Int?){
        self.router = router
        self.name = name
        self.categoryID = categoryID
        super.init(contentRepository: APIContentRepositoryType<MarketAPI, [Product]>(.advancedSearchProducts(categoryID, name)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.router.trigger(.productDetails(unwrappedContent[indexPath.item]))
    }
}
