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
        
        subviews([tableView])
                
        tableView.separatorStyle = .none
        tableView.leading(0).trailing(0).bottom(0).top(0)
        
        tableViewCell.backgroundColor = DefaultColorsProvider.background
        tableViewCell.subviews([allCategoriesCollectionViewWithTitle,itemsCollectionView1, itemCollectionView2])
        
        allCategoriesCollectionViewWithTitle.backgroundColor = DefaultColorsProvider.background
        allCategoriesCollectionViewWithTitle.leading(0).trailing(0).height(151.92 ).top(22.38)
        
        itemsCollectionView1.backgroundColor = DefaultColorsProvider.background
        itemsCollectionView1.leading(0).trailing(0).height(202.01 )
        itemsCollectionView1.Top == allCategoriesCollectionViewWithTitle.Bottom + 19.29
        
        itemCollectionView2.backgroundColor = DefaultColorsProvider.background
        itemCollectionView2.leading(0).trailing(0).height(163.84 )
        itemCollectionView2.Top == itemsCollectionView1.Bottom + 27.64
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
}
