//
//  ItemCategoriesViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 21/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import XCoordinator
import SDWebImage

class ItemCategoriesViewController: SubCategoriesPickerViewController {

    var router: UnownedRouter<ItemsRoute>
    
    init(router: UnownedRouter<ItemsRoute>) {
        self.router = router

        
        let categories = DefaultPreferencesController.shared.selectedCategories ?? []
        let repository = ConstantContentRepository(content: categories)
        super.init(contentRepository: repository)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViewsBeforeTransitioning() {
        super.setupViewsBeforeTransitioning()
        bottomView.removeFromSuperview()
        collectionView.contentInset.bottom = 0
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), action: {})
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! SubCategoryCollectionViewCell
        cell.checkbox.isHidden = true
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.router.trigger(.items(unwrappedContent[indexPath.section].subcategories![indexPath.item]))
    }
}

