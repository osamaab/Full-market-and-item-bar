//
//  MainCategoriesViewController.swift
//  Talabia
//
//  Created by Osama Abu hdba on 21/04/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator
import SDWebImage

class MainCategoryViewController: MainCategoriesPickerViewController {
    
    var router: UnownedRouter<ItemsRoute>
    
    init(router: UnownedRouter<ItemsRoute>) {
        self.router = router
        let contentRepository = MainCategoriesPickerViewController.allCategoriesContent()
        let userType =  UserDefaultsPreferencesManager.shared.userType!
        super.init(contentRepository: contentRepository, userType: userType, title: "")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViewsBeforeTransitioning() {
        super.setupViewsBeforeTransitioning()
        bottomView.removeFromSuperview()
        addBackButton()
        headerView.removeFromSuperview()
        self.title = "Items"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(hex: "#FFFFFF") ]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
       
        collectionView.contentInset.top = 5
        collectionView.top(0).bottom(0).leading(0).trailing(0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! MainCategoryCollectionViewCell
        cell.checkboxView.isHidden = true
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        self.router.trigger(.subCategory(categories[indexPath.item]))
    }
    
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    @objc func backAction(_ sender: UIButton) {
        let _ = navigationController?.popViewController(animated: true)
    }
}

