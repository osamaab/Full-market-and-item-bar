//
//  MarketScreenView.swift
//  talabyeh
//
//  Created by Loai Elayan on 11/1/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import LanguageManager_iOS
import Stevia

class MarketScreenView: UIView, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    let tableViewCell = UITableViewCell()

    let headerView = UIView()
    let headerLabel = UILabel()
    let searchButton = UIButton()
    
    let allCategoriesCollectionViewWithTitle = CollectionViewWithTitleView()
    let itemsCollectionView1 = CollectionViewWithTitleView()
    let itemCollectionView2 = CollectionViewWithTitleView()
    
    convenience init() {
        
        self.init(frame:CGRect.zero)
        backgroundColor = DefaultColorsProvider.background
        
        tableView.delegate = self
        tableView.dataSource = self

        defaultLayout()

    }
    
    final private func defaultLayout(){
        
        subviews([headerView,tableView])
        
        headerView.backgroundColor = Constants.darkGreen
        headerView.leading(0).trailing(0).top(0).height(88.11)
        
        tableView.separatorStyle = .none
        tableView.leading(0).trailing(0).bottom(0)
        tableView.Top == headerView.Bottom
        
        //subviews([headerView,allCategoriesCollectionViewWithTitle,itemsCollectionView1, itemCollectionView2])
        tableViewCell.backgroundColor = DefaultColorsProvider.background
        tableViewCell.subviews([allCategoriesCollectionViewWithTitle,itemsCollectionView1, itemCollectionView2])
        

        
        allCategoriesCollectionViewWithTitle.backgroundColor = DefaultColorsProvider.background
        allCategoriesCollectionViewWithTitle.leading(0).trailing(0).height(151.92 ).top(22.38)
        //allCategoriesCollectionViewWithTitle.Top == headerView.Bottom + 22.38
        
        itemsCollectionView1.backgroundColor = DefaultColorsProvider.background
        itemsCollectionView1.leading(0).trailing(0).height(202.01 )
        itemsCollectionView1.Top == allCategoriesCollectionViewWithTitle.Bottom + 19.29
        
        itemCollectionView2.backgroundColor = DefaultColorsProvider.background
        itemCollectionView2.leading(0).trailing(0).height(163.84 )
        itemCollectionView2.Top == itemsCollectionView1.Bottom + 27.64
        
        // header view
        headerView.subviews([headerLabel, searchButton])
        headerLabel.font = LanguageManager.shared.currentLanguage == .en ? getEnglishFont(17, .semiBold) : getArabicFont(17, .heavy)
        headerLabel.textColor = Constants.whiteText
        headerLabel.centerHorizontally().bottom(12.68).height(20)
        
        
        searchButton.setImage(UIImage(named: "loupe"), for: .normal)
        searchButton.trailing(16).height(16.59).width(16.59)
        searchButton.CenterY == headerLabel.CenterY
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //let height = allCategoriesCollectionViewWithTitle.frame.size.height + itemsCollectionView1.frame.size.height + itemCollectionView2.frame.size.height + 22.38 + 19.29 + 27.64
        return 600//height
    }


}
