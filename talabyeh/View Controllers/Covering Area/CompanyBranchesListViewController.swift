//
//  CompanyBranchesListViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 08/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CompanyBranchesListViewController: UIViewController {
    
    lazy var headerView: NewCompanyBranchHeaderView = .init()
    lazy var collectionView: UICollectionView = makeCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        view.subviewsPreparedAL {
            headerView
            collectionView
        }
        
        headerView.Top == view.safeAreaLayoutGuide.Top + 20
        headerView.leading(0).trailing(0)
        
        collectionView.Top == headerView.Bottom
        collectionView.leading(0).trailing(0).bottom(0)
        
        collectionView.reloadData()
    }
}

extension CompanyBranchesListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: CompanyBranchCollectionViewCell.self, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension CompanyBranchesListViewController {
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

