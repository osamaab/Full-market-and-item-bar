//
//  FavoritesViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 22/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

struct Product: Hashable {
    let title: String
    let id: String = UUID().uuidString
}

class FavoritesViewController: UIViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Product>
    
    lazy var segmentedControl = BigSegmentedControl(items: ["Items", "Companies"])
    lazy var collectionView: UICollectionView = createCollectionView()
    lazy var dataSource: DataSource = createDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
     
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)
        
        segmentedControl.Top == view.safeAreaLayoutGuide.Top + 20
        segmentedControl.leading(20).trailing(20)
        segmentedControl.select(index: 0, animated: true)
        
        collectionView.Top == segmentedControl.Bottom
        collectionView.leading(20).trailing(20)
        collectionView.Bottom == view.safeAreaLayoutGuide.Bottom
        
        let items = (0...9).map { Product(title: "Product \($0)") }
        
        // create a snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Int, Product>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }
}


extension FavoritesViewController {
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: ProductCollectionViewCell.self)
        return collectionView
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemHeightDimension: NSCollectionLayoutDimension = .estimated(180)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                              heightDimension: itemHeightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: itemHeightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        group.interItemSpacing = .fixed(20)

        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func createDataSource() -> DataSource {
        return UICollectionViewDiffableDataSource<Int, Product>(collectionView: self.collectionView) { (collectionView, indexPath, product) -> UICollectionViewCell? in
            let cell = collectionView.dequeueCell(cellClass: ProductCollectionViewCell.self, for: indexPath)
            
            cell.imageView.image = UIImage(named: "Rectangle 232")
            cell.subtitleLabel1.text = "Red Onions"
            cell.titleLabel.text = "New era market"
            cell.subtitleLabel2.text = "JD 0.200"
            
            return cell
        }
    }
}
