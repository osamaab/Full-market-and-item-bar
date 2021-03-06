//
//  SelectPreferredDistributorViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 04/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia


class SelectPreferredDistributorViewController: UIViewController {
    
    lazy var headerView: SortAndFilterCollectionReusableView = .init()
    lazy var collectionView: UICollectionView = makeCollectionView()
    lazy var saveView: BottomNextButtonView = .init(title: "Save")
    
    var selectedIndexPath: IndexPath?
    
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.subviewsPreparedAL {
            headerView
            collectionView
            saveView
        }
        
        headerView.Top == view.safeAreaLayoutGuide.Top + 20
        headerView.leading(20).trailing(20)
        
        
        collectionView.Top == headerView.Bottom
        collectionView.leading(0).trailing(0)
        
        saveView.Top == collectionView.Bottom
        saveView.leading(0).trailing(0).bottom(0)
        
        collectionView.contentInset.top = 10
        collectionView.contentInset.bottom = 10
        
        headerView.isHidden = true
        collectionView.reloadData()
    }
}

extension SelectPreferredDistributorViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: DistributorWithCheckboxCollectionViewCell.self, for: indexPath)
        
        if indexPath == selectedIndexPath {
            cell.update(style: .selected)
        } else {
            cell.update(style: .regular)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        self.collectionView.reloadData()
    }
}

extension SelectPreferredDistributorViewController {
    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(cellClass: DistributorWithCheckboxCollectionViewCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
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
        section.contentInsets = .init(top: 20, leading: 0, bottom: 5, trailing: 0)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        if #available(iOS 14.0, *) {
            configuration.contentInsetsReference = .safeArea
        }
        
        layout.configuration = configuration
        
        return layout
    }
}
