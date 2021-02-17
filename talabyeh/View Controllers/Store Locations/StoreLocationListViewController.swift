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

class StoreLocationListViewController: ContentViewController<[StoreLocation]> {
    
    lazy var headerView: NewStoreLocationHeaderView = .init()
    lazy var collectionView: UICollectionView = makeCollectionView()
    
    override var requiresAuthentication: Bool {
        true
    }
    
    let router: UnownedRouter<StoreLocationsRoute>
    
    init(router: UnownedRouter<StoreLocationsRoute>){
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
        /*
        Because yet we don't know how many detail item each store location has, we register cells based on the number of detail items each store location has, this ensures cells reused have the same number of detail item, so no need to manipulate the view each time we call reuseCell.
         */
        Set(content.map { $0.detailItems() }.map {
            "store_location_with_\($0.count)_items"
        }).forEach {
            print("registering a new cell with \($0)")
            collectionView.register(StoreLocationCollectionViewCell.self, forCellWithReuseIdentifier: $0)
        }
        
        
        
        collectionView.reloadData()
    }
}

extension StoreLocationListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        content?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = unwrappedContent[indexPath.item]
        
        /*
         dequeues a cell for a specific number of items, this ensures performance.
         */
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "store_location_with_\(item.detailItems().count)_items", for: indexPath) as! StoreLocationCollectionViewCell
        
        cell.titleLabel.text = item.name
        cell.summaryLabel.text = item.formattedSummary()
        cell.summaryLabel.isHidden = item.formattedSummary().isEmpty
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

extension StoreLocationListViewController {
    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        collectionView.backgroundColor = .clear
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


extension StoreLocationCollectionViewCell {
    func set(items: [StoreLocation.DetailItem]){
        if self.labelsViews.count != items.count {
            // reset the label views, this should happen only once.
            print("Resetting Labels count for \(items.count)")
            
            labelsViews.forEach {
                containerStackView.removeArrangedSubview($0)
                $0.removeFromSuperview()
            }
            
            self.labelsViews.removeAll()
            
            // attempt to insert label views with items count
            items.forEach {
                self.insertLabelView(with: $0.text, icon: UIImage(named: "store_\($0.identifier.rawValue)"))
            }
            
            return
        }
         
        print("Reusing existing Labels for \(items.count)")
        items.enumerated().forEach {
            let index = $0.offset
            let element = $0.element
            
            if index < labelsViews.count {
                labelsViews[index].icon = UIImage(named: "store_\(element.identifier.rawValue)")
                labelsViews[index].titleLabel.text = element.text
            }
        }
    }
}
