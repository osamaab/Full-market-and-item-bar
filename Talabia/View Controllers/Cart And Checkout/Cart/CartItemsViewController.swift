//
//  CartItemsViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 26/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia
import XCoordinator

class CartItemsViewController: UIViewController {

    
    @Injected var cartManager: CartManagerType
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, CartItem>
    
    lazy var collectionView: UICollectionView = createCollectionView()
    lazy var dataSource: DataSource = createDataSource()
    lazy var cartSummaryView = CartSummaryView()
    
    let router: UnownedRouter<CartRoute>
    
    internal init(router: UnownedRouter<CartRoute>) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cart"
        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        view.subviewsPreparedAL {
            collectionView
            cartSummaryView
        }
        
        collectionView.Top == view.safeAreaLayoutGuide.Top
        collectionView.leading(0).trailing(0).bottom(0)
        cartSummaryView.leading(0).trailing(0).bottom(0)
        
        cartSummaryView.add(gesture: .tap(1)) { [unowned self] in
            if let contents = self.cartManager.contents() {
                self.router.trigger(.checkout(contents))
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // create a snapshot of the current state and return
        if let products = self.cartManager.products {
            var snapshot = NSDiffableDataSourceSnapshot<Int, CartItem>()
            snapshot.appendSections([1])
            snapshot.appendItems(Array(products))
            dataSource.apply(snapshot)
        }
        
        if let products = self.cartManager.products {
            self.cartSummaryView.isHidden = false
            cartSummaryView.titleLabel.text = "Subtotal ( \(products.count) )"
            cartSummaryView.valueLabel.text = "JD\(self.cartManager.totalPrice())"
        } else {
            self.cartSummaryView.isHidden = true
        }
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
        return UICollectionViewDiffableDataSource<Int, CartItem>(collectionView: self.collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueCell(cellClass: CartCollectionViewCell.self, for: indexPath)
            cell.backgroundColor = .red
            cell.quantitySelectionView.value = item.quantity
            cell.imageView.sd_setImage(with: item.product.images.first?.url, completed: nil)
            cell.titleLabel.text = item.product.item.name
            cell.subtitleLabel.text = "JD\(item.product.price)"
            cell.quantitySelectionView.onValueChange = { [unowned self] newValue in
                self.cartManager.set(quantity: newValue, for: item.product)
            }
            
            return cell
        }
    }
}
