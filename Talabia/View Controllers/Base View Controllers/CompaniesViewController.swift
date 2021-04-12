//
//  CompaniesViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 01/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CompaniesViewController: ContentViewController<[Company]> {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Company>
    
    lazy var collectionView: UICollectionView = createCollectionView()
    lazy var dataSource: DataSource = createDataSource()
    
    var isFavoriteFeatureAvailable: Bool {
        false
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
    
    override func contentRequestDidSuccess(with content: [Company]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Company>()
        snapshot.appendSections([0])
        snapshot.appendItems(content)
        dataSource.apply(snapshot)
    }
    
    func configureItem(item: Company, for cell: CompanyCollectionViewCell, at indexPath: IndexPath){
        cell.imageView.sd_setImage(with: URL(string: item.logoPath), completed: nil)
        cell.titleLabel.text = item.title
    }
}

extension CompaniesViewController {
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: CompanyCollectionViewCell.self)
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
        return UICollectionViewDiffableDataSource<Int, Company>(collectionView: self.collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueCell(cellClass: CompanyCollectionViewCell.self, for: indexPath)
            self.configureItem(item: item, for: cell, at: indexPath)
            
            return cell
        }
    }
}
