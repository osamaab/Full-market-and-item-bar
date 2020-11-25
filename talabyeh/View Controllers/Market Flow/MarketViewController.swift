//
//  MarketScreenViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 11/1/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import LanguageManager_iOS
import Stevia

class MarketViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let headerKind = "header-kind"
    let sectionsCount: Int = 4
        
    lazy var collectionView: UICollectionView = createCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(CollectionViewSectionHeader.self, forSupplementaryViewOfKind: headerKind, withReuseIdentifier: CollectionViewSectionHeader.identifier)
        collectionView.register(cellClass: MarketCategoryCollectionViewCell.self)
        collectionView.register(cellClass: ProductCollectionViewCell.self)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.fillContainer()
    }
}

extension MarketViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sectionsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueCell(cellClass: MarketCategoryCollectionViewCell.self, for: indexPath)
            
            cell.cImage.image = UIImage(named: "dummy4")
            cell.cTitle.text = "Meat"
            
            return cell
        case 1..<sectionsCount - 1:
            let cell = collectionView.dequeueCell(cellClass: ProductCollectionViewCell.self, for: indexPath)
            
            cell.imageView.image = UIImage(named: "Rectangle 232")
            cell.subtitleLabel1.text = "Red Onions"
            cell.titleLabel.text = "New era market"
            cell.subtitleLabel2.text = "JD 0.200"
            
            return cell
        case sectionsCount - 1:
            let cell = collectionView.dequeueCell(cellClass: ProductCollectionViewCell.self, for: indexPath)
            
            cell.imageView.image = UIImage(named: "Rectangle 232")
            cell.subtitleLabel1.text = "Red Onions"
            cell.titleLabel.text = "New era market"
            cell.subtitleLabel2.text = "JD 0.200"
            
            return cell
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == headerKind {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewSectionHeader.identifier, for: indexPath) as! CollectionViewSectionHeader
            header.titleLable.text = "All Categories"
            header.seeMoreButton.setTitle("View All", for: .normal)
            return header
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let next = MarketCategoriesViewController()
            self.navigationController?.pushViewController(next, animated: true)
        } else {
            let next = ProductDetailsViewController()
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
}


extension MarketViewController {
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = DefaultColorsProvider.background
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: AdvancedSearchFolderCollectionViewCell.self)
        return collectionView
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, enviroment) -> NSCollectionLayoutSection? in
            
            let section: NSCollectionLayoutSection
            switch sectionIndex {
            case 0:
                let itemHeightDimension: NSCollectionLayoutDimension = .absolute(120)
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                      heightDimension: itemHeightDimension)
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: itemHeightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 4)
                group.interItemSpacing = .fixed(15)
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 15
                
                
            case 1..<self.sectionsCount - 1:
                let itemHeightDimension: NSCollectionLayoutDimension = .estimated(180)
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                      heightDimension: itemHeightDimension)
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: itemHeightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
                group.interItemSpacing = .fixed(8)

                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
            case self.sectionsCount - 1:
                let itemHeightDimension: NSCollectionLayoutDimension = .estimated(180)
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                      heightDimension: itemHeightDimension)
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: itemHeightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
                group.interItemSpacing = .fixed(15)

                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 15
            default:
                fatalError("No more than 4 sections are supported in the market layout")
            }
            
            
            
            // the height of the header must include the content inset ( vertical dimensions )
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: self.headerKind, alignment: .top)
            header.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            section.boundarySupplementaryItems = [
                header
            ]
            
            section.contentInsets = .init(top: 0, leading: 20, bottom: 20, trailing: 20)
            return section
        }
        
        
        return layout
    }
}
