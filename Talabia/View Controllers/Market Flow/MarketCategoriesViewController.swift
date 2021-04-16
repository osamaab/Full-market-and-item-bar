//
//  MarketCategoriesViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 22/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class MarketCategoriesViewController: ContentViewController<[MainCategory]>, UICollectionViewDataSource, UICollectionViewDelegate  {
    
        
static let headerElementKind = "header"
    
    lazy var titleLabel: UILabel = .init()
    lazy var collectionView: UICollectionView = configureCollectionView()
    lazy var bottomView: BottomNextButtonView = .init(title: "Next")
   
    var items: [MainCategory] {
        content ?? []
    }
    

    
    override func setupViewsBeforeTransitioning() {
        title = "Categories"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"search-Icon"), action: {})
        addBackButton()
               
        view.addSubview(collectionView)

        collectionView.Width == view.Width
        collectionView.Height == view.Height
        collectionView.leading(7).trailing(7).top(0).bottom(0)
        collectionView.contentInset = .init(top: 15, left: 0, bottom: 0, right: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
       
        }
    
    override func contentRequestDidSuccess(with content: [MainCategory]) {
        self.collectionView.reloadData()
    }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            items[section].subcategories?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueCell(cellClass: MarketAllSubCategorysCollectionViewCell.self, for: indexPath)
            let category = items[indexPath.section].subcategories?[indexPath.item]
            cell.imageView.sd_setImage(with: category?.imageURL)
            cell.titleLabel.text = category?.title
            
            return cell
        }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == Self.headerElementKind else {
            return .init()
        }

        let header = collectionView.dequeReusableView(reusableViewType: CategoryCollectionReusableView.self, kind: Self.headerElementKind, for: indexPath)
        let category = self.items[indexPath.section]
        
        header.titleLabel.text = category.title
        header.imageView.sd_setImage(with: category.logo)

        return header
    }
}
extension MarketCategoriesViewController {
    func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(cellClass: MarketAllSubCategorysCollectionViewCell.self)
        collectionView.register(reusableViewClass: CategoryCollectionReusableView.self, for: Self.headerElementKind)

        return collectionView
    }
    
    func generateLayout() -> UICollectionViewLayout {
            
        let itemSize = NSCollectionLayoutSize(
           widthDimension: .fractionalWidth(1.0),
           heightDimension: .fractionalHeight(1.0))
         let ItemSpace = NSCollectionLayoutItem(layoutSize: itemSize)
        ItemSpace.contentInsets = NSDirectionalEdgeInsets(
          top: 10,
          leading: 7,
          bottom: 5,
          trailing: 7)
         
        let groupSize = NSCollectionLayoutSize(
           widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.4))
         let group = NSCollectionLayoutGroup.horizontal(
           layoutSize: groupSize,
           subitem: ItemSpace,
           count: 3)
//        group.contentInsets = NSDirectionalEdgeInsets(top: <#T##CGFloat#>, leading: <#T##CGFloat#>, bottom: <#T##CGFloat#>, trailing: <#T##CGFloat#>)
         let section = NSCollectionLayoutSection(group: group)
        let boundaryItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .estimated(60))
        let boundaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: boundaryItemSize,
                                                                       elementKind: Self.headerElementKind,
                                                                       alignment: .top)
        section.boundarySupplementaryItems = [
            boundaryItem
        ]
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 35, trailing: 0)
        return UICollectionViewCompositionalLayout(section: section)
    }
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    @objc func backAction(_ sender: UIButton) {
        let _ = navigationController?.popViewController(animated: true)
    }
}

