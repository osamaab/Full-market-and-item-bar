//
//  CategoriesPickerViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 20/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia


class CategoriesPickerViewController: UIViewController {
    
    lazy var headerView: AuthHeaderView = .init(elements: AuthHeaderView.Element.allCases)
    lazy var collectionView: UICollectionView = configureCollectionView()
    lazy var bottomView: BottomNextButtonView = .init(title: "Next")

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = .white
        navigationItem.title = "Category"
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white

        headerView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        view.subviews {
            headerView
            collectionView
            bottomView
        }
        
        headerView.Top == view.safeAreaLayoutGuide.Top + 15
        headerView.leading(20).centerHorizontally()
        
        collectionView.leading(0).trailing(0)
        collectionView.Top == headerView.Bottom
        
        bottomView.leading(0).trailing(0).bottom(0)
        bottomView.Top == collectionView.Bottom
        
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}

extension CategoriesPickerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: CategoryItemCollectionViewCell.self, for: indexPath)
        
        return cell
    }
}

extension CategoriesPickerViewController {
    func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: CategoryItemCollectionViewCell.self)
        
        return collectionView
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let itemHeightDimension: NSCollectionLayoutDimension = .absolute(120)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                              heightDimension: itemHeightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: itemHeightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        group.interItemSpacing = .fixed(15)
        group.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        section.interGroupSpacing = 15
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}



