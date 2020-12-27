//
//  CompanyLocationsContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 16/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CompanyLocationsContentView: BasicViewWithSetup {
    
    let titleView: LabelView = .init(title: "Company full location/s", icon: UIImage(named: "clock_small"))
    let plusButton: UIButton = .init()

    lazy var collectionView: UICollectionView = makeCollectionView()
    
    override func setup() {
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        plusButton.tintColor = DefaultColorsProvider.tintPrimary
        plusButton.setImage(UIImage(named: "plus_small"), for: .normal)
        
        subviewsPreparedAL {
            titleView
            plusButton
            collectionView
        }
        
        
        titleView.top(0).leading(20)
        plusButton.trailing(20).width(20).height(20)
        collectionView.Top == titleView.Bottom + 15
        
        plusButton.CenterY == titleView.CenterY
        plusButton.Leading == titleView.Trailing + 15
        
        collectionView.leading(0).trailing(0).bottom(0)
        collectionView.reloadData()
    }
}

extension CompanyLocationsContentView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: CompanyLocationCollectionViewCell.self, for: indexPath)
        return cell
    }
}

extension CompanyLocationsContentView {
    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        collectionView.backgroundColor = DefaultColorsProvider.backgroundSecondary
        collectionView.register(cellClass: CompanyLocationCollectionViewCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(220))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        if #available(iOS 14.0, *) {
            configuration.contentInsetsReference = .safeArea
        }
        
        layout.configuration = configuration
        
        return layout
    }
}
