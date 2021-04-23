//
//  BaseOrdersListViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class BaseOrdersListViewController: UIViewController {

    lazy var collectionView = makeCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.fillContainer()
        
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
    }
}

extension BaseOrdersListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueCell(cellClass: OngoingOperationCollectionViewCell.self, for: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueCell(cellClass: FinishedOperationCollectionViewCell.self, for: indexPath)
            return cell
        case 2:
            let cell = collectionView.dequeueCell(cellClass: FaildOperationCollectionViewCell.self, for: indexPath)
            return cell
        default:
            let cell = collectionView.dequeueCell(cellClass: PendingOperationCollectionViewCell.self, for: indexPath)
            return cell
        }
    }
}



extension BaseOrdersListViewController {
    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(cellClass: OngoingOperationCollectionViewCell.self)
        collectionView.register(cellClass: FinishedOperationCollectionViewCell.self)
        collectionView.register(cellClass: FaildOperationCollectionViewCell.self)
        collectionView.register(cellClass: PendingOperationCollectionViewCell.self)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(210))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(240))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        group.interItemSpacing = .fixed(20)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        if #available(iOS 14.0, *) {
            configuration.contentInsetsReference = .safeArea
        }
        
        layout.configuration = configuration
        
        return layout
    }
}
