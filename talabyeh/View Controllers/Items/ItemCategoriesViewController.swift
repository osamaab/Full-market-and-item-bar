//
//  ItemCategoriesViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 21/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

struct ItemsCategory: Hashable {
    let id: String = UUID().uuidString
    let title: String
}

class ItemCategoriesViewController: UIViewController, UICollectionViewDelegate {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, ItemsCategory>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, ItemsCategory>
    
    lazy var collectionView: UICollectionView = createCollectionView(for: createLayout())
    lazy var dataSource: DataSource = createDataSource(for: collectionView)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        setupCollectionView()
        
        collectionView.delegate = self
        setupDataAndCreateSnapshot()
    }
    
    func setupCollectionView(){
        view.subviewsPreparedAL {
            collectionView
        }
        
        collectionView.Top == view.safeAreaLayoutGuide.Top
        collectionView.leading(20).trailing(20)
        collectionView.Bottom == view.safeAreaLayoutGuide.Bottom
    }
    
    func setupDataAndCreateSnapshot(){
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems( (0..<15).map { ItemsCategory(title: "Cat \($0)") } )
        dataSource.apply(snapshot)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let itemID = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        
    }
}

extension ItemCategoriesViewController {
    func createDataSource(for collectionView: UICollectionView) -> DataSource {
        return DataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueCell(cellClass: ItemCategoryCollectionViewCell.self, for: indexPath)
            cell.titleLabel.text = item.title
            return cell
        }
    }
    
    func createCollectionView(for layout: UICollectionViewLayout) -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: ItemCategoryCollectionViewCell.self)
        return collectionView
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(55))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
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
