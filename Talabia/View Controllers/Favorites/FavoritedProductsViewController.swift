//
//  FavoritedProductsViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 15/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia
import XCoordinator

class FavoritedProductsViewController: ProductsViewController {
    
    let router: UnownedRouter<FavoritesRoute>
    
    init(router: UnownedRouter<FavoritesRoute>){
        self.router = router
        super.init(contentRepository: APIContentRepositoryType<FavoritesAPI, [Product]>(.products))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureItem(item: Product, for cell: ProductCollectionViewCell, at indexPath: IndexPath) {
        cell.likeButton.isHidden = false
        cell.likeButton.isChecked = true
        
        cell.likeButton.add(event: .valueChanged) { [unowned self] in
            if cell.likeButton.isChecked {
                self.router.trigger(.favoriteProduct(item))
            } else {
                self.router.trigger(.unfavoriteProduct(item))
            }
        }
    }
}
