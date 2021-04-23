//
//  FavoritedCompaniesViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 15/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia
import XCoordinator

class FavoritedCompaniesViewController: CompaniesViewController {

    let router: UnownedRouter<FavoritesRoute>
    
    init(router: UnownedRouter<FavoritesRoute>){
        self.router = router
        super.init(contentRepository: APIContentRepositoryType<FavoritesAPI, [Company]>(.companies))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureItem(item: Company, for cell: CompanyCollectionViewCell, at indexPath: IndexPath) {
        cell.imageView.sd_setImage(with: URL(string: item.logoPath), completed: nil)
        cell.titleLabel.text = item.title
        
        cell.likeButton.add(event: .valueChanged) { [unowned self] in
            if cell.likeButton.isChecked {
                self.router.trigger(.favoriteCompany(item))
            } else {
                self.router.trigger(.unfavoriteCompany(item))
            }
        }
    }
}
