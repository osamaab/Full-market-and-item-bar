//
//  FavoritedProductsViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 15/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia
import XCoordinator

class FavoritedProductsViewController: ContentViewController<[Product]> {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Product>
    
    lazy var collectionView: UICollectionView = createCollectionView()
    lazy var dataSource: DataSource = createDataSource()
    
    let router: UnownedRouter<FavoritesRoute>
    
    init(router: UnownedRouter<FavoritesRoute>){
        self.router = router
        super.init(contentRepository: APIContentRepositoryType<FavoritesAPI, [Product]>(.products))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViewsBeforeTransitioning() {
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary

        view.subviewsPreparedAL {
            collectionView
        }
        
        collectionView.Top == view.Top
        collectionView.leading(20).trailing(20)
        collectionView.Bottom == view.safeAreaLayoutGuide.Bottom
    }
    
    override func contentRequestDidSuccess(with content: [Product]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Product>()
        snapshot.appendSections([0])
        snapshot.appendItems(content)
        dataSource.apply(snapshot)
    }
}

extension FavoritedProductsViewController {
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
        return UICollectionViewDiffableDataSource<Int, Product>(collectionView: self.collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueCell(cellClass: ProductCollectionViewCell.self, for: indexPath)
            
            cell.titleLabel.text = item.username
            cell.subtitleLabel1.text = item.item.name
            cell.subtitleLabel2.text = "PRICE"
            cell.topLabel.text = item.item.unit.title
            cell.likeButton.isChecked = true // by default
            
            cell.likeButton.add(event: .valueChanged) { [unowned self] in
                if cell.likeButton.isChecked {
                    self.router.trigger(.favoriteProduct(item))
                } else {
                    self.router.trigger(.unfavoriteProduct(item))
                }
            }
            
            return cell
        }
    }
}
