//
//  OrderHistoryViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 24/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator


class CompanyDistributorOrderHistoryViewController: OrderHistoryViewController {
    
    let distributor: Distributor
    let router: UnownedRouter<DistributorsRoute>
    
    init(distributor: Distributor, router: UnownedRouter<DistributorsRoute>){
        self.router = router
        self.distributor = distributor
//        super.init(contentRepository: APIContentRepositoryType<DistributorsAPI, [OrderHistoryItem]>(.orderHistoryCategories))
        
        super.init(contentRepository: ConstantContentRepository(content: [
            OrderHistoryItem(month: 2, year: 1999, orderHeaderIds: "1"),
            OrderHistoryItem(month: 2, year: 1999, orderHeaderIds: "1"),
            OrderHistoryItem(month: 2, year: 1999, orderHeaderIds: "1"),
            OrderHistoryItem(month: 2, year: 1999, orderHeaderIds: "1")
        ]))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class OrderHistoryViewController: ContentViewController<[OrderHistoryItem]> {

    lazy var collectionView = createCollectionView()
    
    override func setupViewsBeforeTransitioning() {
        view.addSubview(collectionView)
        collectionView.fillContainer()
        
        collectionView.dataSource = self
        
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
    }
    
    override func contentRequestDidSuccess(with content: [OrderHistoryItem]) {
        self.collectionView.reloadData()
    }
}

extension OrderHistoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        content?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: OrderHistoryItemCollectionViewCell.self, for: indexPath)
        let item = self.unwrappedContent[indexPath.item]
        
        cell.titleLabel.text = "\(item.month) / \(item.year)"
        
        return cell
    }
}

extension OrderHistoryViewController {
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createCollectionViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: OrderHistoryItemCollectionViewCell.self)
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
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
