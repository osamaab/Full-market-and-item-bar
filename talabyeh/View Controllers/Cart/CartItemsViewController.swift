//
//  CartItemsViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 26/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

struct CartItem: Hashable {
    let product: Product
    let quantity: Int
    let discountPercentage: Double
}

class CartItemsViewController: UIViewController {

    typealias DataSource = UICollectionViewDiffableDataSource<Int, CartItem>
    
    lazy var collectionView: UICollectionView = createCollectionView()
    lazy var dataSource: DataSource = createDataSource()
    lazy var cartSummaryView = CartSummaryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.background1
     
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        cartSummaryView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        view.addSubview(cartSummaryView)
        
        collectionView.Top == view.safeAreaLayoutGuide.Top
        collectionView.leading(0).trailing(0).bottom(0)
        
        cartSummaryView.leading(0).trailing(0).height(80)
        cartSummaryView.Bottom == view.safeAreaLayoutGuide.Bottom + 5
        
        
        let items = (0...3).map { CartItem(product: Product(title: "Product \($0)"), quantity: $0 + 1, discountPercentage: $0.isMultiple(of: 2) ? 0.5 : 0) }
        
        // create a snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Int, CartItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.contentInset.bottom = 100
    }
}

extension CartItemsViewController {
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: CartCollectionViewCell.self)
        return collectionView
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemHeightDimension: NSCollectionLayoutDimension = .estimated(180)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: itemHeightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: itemHeightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func createDataSource() -> DataSource {
        return UICollectionViewDiffableDataSource<Int, CartItem>(collectionView: self.collectionView) { (collectionView, indexPath, product) -> UICollectionViewCell? in
            let cell = collectionView.dequeueCell(cellClass: CartCollectionViewCell.self, for: indexPath)
            
            cell.imageView.image = UIImage(named: "Rectangle 232")
            cell.titleLabel.text = "New era market"
            cell.subtitleLabel.text = "Unit Price JD 0.200"
            
            
            return cell
        }
    }
}
