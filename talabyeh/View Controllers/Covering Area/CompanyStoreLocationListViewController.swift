//
//  CompanyBranchesListViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 08/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator
import Stevia

class CompanyStoreLocationListViewController: ContentViewController<[StoreLocation]> {
    
    lazy var headerView: NewCompanyBranchHeaderView = .init()
    lazy var collectionView: UICollectionView = makeCollectionView()
    
    override var requiresAuthentication: Bool {
        true
    }
    
    let router: UnownedRouter<CompanyBranchesRoute>
    
    init(router: UnownedRouter<CompanyBranchesRoute>){
        self.router = router
        super.init(contentRepository: APIContentRepositoryType<StoreLocationsAPI, [StoreLocation]>(.storeLocations))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViewsBeforeTransitioning() {
        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        view.subviewsPreparedAL {
            headerView
            collectionView
        }
        
        headerView.Top == view.safeAreaLayoutGuide.Top + 20
        headerView.leading(0).trailing(0)
        
        headerView.add(gesture: .tap(1)) { [unowned self] in
            self.router.trigger(.new)
        }
        
        collectionView.Top == headerView.Bottom
        collectionView.leading(0).trailing(0).bottom(0)
    }
    
    override func contentRequestDidSuccess(with content: [StoreLocation]) {
        collectionView.reloadData()
    }
}

extension CompanyStoreLocationListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        content?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: CompanyBranchCollectionViewCell.self, for: indexPath)
        let item = unwrappedContent[indexPath.item]
        
        cell.titleLabel.text = item.name
        cell.summaryLabel.text = item.formattedSummary()
        cell.subtitleLabel.text = item.formattedAddress()
        cell.set(items: item.detailItems())
        
        
        cell.onEditTap = { [unowned self] in
            self.router.trigger(.edit(item))
        }
        
        cell.onMapTap = { [unowned self] in
            self.router.trigger(.map(item))
        }
        
        return cell
    }
}

extension CompanyStoreLocationListViewController {
    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(cellClass: CompanyBranchCollectionViewCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(315))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        section.interGroupSpacing = 15
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        if #available(iOS 14.0, *) {
            configuration.contentInsetsReference = .safeArea
        }
        
        layout.configuration = configuration
        
        return layout
    }
}

