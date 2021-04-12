//
//  DistributorsListViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 17/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

class DistributorsListViewController: ContentViewController<[Distributor]> {
    
    lazy var collectionView = makeCollectionView()
    
    let router: UnownedRouter<DistributorsRoute>
    
    init(router: UnownedRouter<DistributorsRoute>){
        self.router = router
        super.init(contentRepository: APIContentRepositoryType<DistributorsAPI, [Distributor]>(.list))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViewsBeforeTransitioning() {
        title = "Distributors"
        view.addSubview(collectionView)
        collectionView.fillContainer()
        
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
    }
    
    override func contentRequestDidSuccess(with content: [Distributor]) {
        self.collectionView.reloadData()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, action: { [unowned self] in
            self.router.trigger(.new)
        })
    }
}

extension DistributorsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        content?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: DistributerCollectionViewCell.self, for: indexPath)
        let item = unwrappedContent[indexPath.item]
        
        cell.titleLabel.text = item.name
        cell.subtitleLabel.text = item.mobile
        cell.phoneActionView.isHidden = true
        cell.locationActionView.isHidden = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.router.trigger(.profile(unwrappedContent[indexPath.item]))
    }
}

extension DistributorsListViewController {
    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(cellClass: DistributerCollectionViewCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(90))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)

        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        if #available(iOS 14.0, *) {
            configuration.contentInsetsReference = .safeArea
        }
        
        layout.configuration = configuration
        
        return layout
    }
}

