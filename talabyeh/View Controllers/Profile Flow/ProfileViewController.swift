//
//  ProfilePageViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/25/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

/**
 The Profile view controller acts as a generic view controller displaying information on the header, with menu items can be actionable
 */
class ProfileViewController: UIViewController {
    
    var headerInfo: ProfileHeaderInfo
    var menuItems: [ProfileMenuItem]
    
    lazy var collectionView: UICollectionView = createCollectionView()
    lazy var headerView: ProfileHeaderView = .init()
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    init(headerInfo: ProfileHeaderInfo, menuItems: [ProfileMenuItem]){
        self.headerInfo = headerInfo
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        view.subviewsPreparedAL {
            headerView
            collectionView
        }
        
        headerView.Top == view.safeAreaLayoutGuide.Top
        headerView.leading(0).trailing(0)
        
        collectionView.Top == headerView.Bottom
        collectionView.leading(0).trailing(0).bottom(0)
        
        collectionView.dataSource = self
        collectionView.reloadData()
        
        
        headerView.imageView.sd_setImage(with: headerInfo.imageURL)
        headerView.titleLabel.text = headerInfo.title
        headerView.subtitleLabel.text = headerInfo.subtitle
        headerView.tertiaryLabel.text = headerInfo.subtitle2
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: ProfileMenuItemCollectionViewCell.self, for: indexPath)
        let item = menuItems[indexPath.item]
        
        cell.imageView.image = item.image
        cell.titleLabel.text = item.title
        
        return cell
    }
}


extension ProfileViewController {
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createCollectionViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: ProfileMenuItemCollectionViewCell.self)
        return collectionView
    }
    
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let itemHeightDimension: NSCollectionLayoutDimension = .absolute(60)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: itemHeightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: itemHeightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
