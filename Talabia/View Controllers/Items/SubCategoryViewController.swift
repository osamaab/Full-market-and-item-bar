//
//  SubCategoryViewController.swift
//  Talabia
//
//  Created by Osama Abu hdba on 21/04/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator
import Stevia
import SDWebImage

class SubCategoryViewController: ContentViewController<MainCategory>, UICollectionViewDataSource, UICollectionViewDelegate {
   
    
    
    var router: UnownedRouter<ItemsRoute>
    lazy var collectionView: UICollectionView = configureCollectionView()
    let preferencesManager = UserDefaultsPreferencesManager.shared
    let category: MainCategory
    init(router: UnownedRouter<ItemsRoute>,category: MainCategory) {
        self.router = router
        self.category = category
        let repository = ConstantContentRepository(content: category)
        super.init(contentRepository: repository)
    }
    var item: MainCategory {
        content!
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    static let headerElementKind = "header"
    override func setupViewsBeforeTransitioning() {
        title = "Categories"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), action: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        })
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"search-Icon"), action: {})
        view.addSubview(collectionView)
        collectionView.contentInset.top = 20
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.top(0).bottom(0).leading(7).trailing(7)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        category.subcategories?.count ?? 0
    }
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: SubCategoryCollectionViewCell.self, for: indexPath)
        let category = item.subcategories?[indexPath.item]
        cell.imageView.sd_setImage(with: category?.imageURL)
        cell.titleLabel.text = category?.title
        cell.checkbox.isHidden = true
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.router.trigger(.items(unwrappedContent.subcategories![indexPath.item]))

    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == Self.headerElementKind else {
            return .init()
        }
        
        
        let header = collectionView.dequeReusableView(reusableViewType: CategoryCollectionReusableView.self, kind: Self.headerElementKind, for: indexPath)
        let category = self.item
        
        header.titleLabel.text = category.title
        header.imageView.sd_setImage(with: category.logo)


        return header
    }
}
extension SubCategoryViewController {
    func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(cellClass: SubCategoryCollectionViewCell.self)
        collectionView.register(reusableViewClass: CategoryCollectionReusableView.self, for: Self.headerElementKind)

        return collectionView
    }
    
    func generateLayout() -> UICollectionViewLayout {
//
        let itemSize = NSCollectionLayoutSize(
           widthDimension: .fractionalWidth(1.0),
           heightDimension: .fractionalHeight(1.0))
         let ItemSpace = NSCollectionLayoutItem(layoutSize: itemSize)
        ItemSpace.contentInsets = NSDirectionalEdgeInsets(
          top: 10,
          leading: 10,
          bottom: 10,
          trailing: 10)
         //2
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.37))
         let group = NSCollectionLayoutGroup.horizontal(
           layoutSize: groupSize,
           subitem: ItemSpace,
           count: 3)
//        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
         //3
         let section = NSCollectionLayoutSection(group: group)
//         let layout = UICollectionViewCompositionalLayout(section: section)
//         return layout
        let boundaryItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                      heightDimension: .estimated(60))
        let boundaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: boundaryItemSize,
                                                                       elementKind: Self.headerElementKind,
                                                                       alignment: .top)
        section.boundarySupplementaryItems = [
            boundaryItem
        ]
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 35, trailing: 0)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
