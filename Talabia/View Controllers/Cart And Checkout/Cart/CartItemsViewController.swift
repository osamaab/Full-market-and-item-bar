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
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, CartItem>
   
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
        title = "My cart"
        applySnapshot()


        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        collectionView.delegate = self
        view.subviewsPreparedAL {
            collectionView
            cartSummaryView
        }
        
        
        collectionView.Top == view.safeAreaLayoutGuide.Top
        collectionView.leading(0).trailing(0).bottom(0)
        cartSummaryView.leading(0).trailing(0).bottom(3)
        
        cartSummaryView.add(gesture: .tap(1)) { [unowned self] in
            if let contents = self.cartManager.contents() {
                self.router.trigger(.checkout(contents))
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applySnapshot()
    }
    override func viewDidAppear(_ animated: Bool) {
        applySnapshot()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.contentInset.bottom = 100
    }
    
    func updateTotalSummary(){
        let items = self.cartManager.orderedItems()
        if items.count != 0 {
            self.cartSummaryView.isHidden = false
            cartSummaryView.titleLabel.text = "Subtotal ( \(items.count) )"
            cartSummaryView.valueLabel.text = "JD\(String(format:"%.2f", self.cartManager.totalPrice()))"
        } else {
            self.cartSummaryView.isHidden = true
        }
    }
    
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        DispatchQueue.main.async {
            let products = self.cartManager.orderedItems()
            
            print("applying snapshot, number of items..: \(products.count)")

            
            var snapshot = NSDiffableDataSourceSnapshot<Int, CartItem>()
            snapshot.appendSections([1])
            snapshot.appendItems(Array(products))
            self.dataSource.apply(snapshot)
            self.updateTotalSummary()
            if let tabItems = self.tabBarController?.tabBar.items {
            let tabItem = tabItems[1]
            tabItem.badgeValue = "\(self.cartManager.orderedItems().count)"
                if self.cartManager.orderedItems().count == 0 {
                    tabItem.badgeValue = nil
                }
            }
            
        }
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
        let itemHeightDimension: NSCollectionLayoutDimension = .fractionalHeight(1.0)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: itemHeightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 1, leading: 0, bottom: 1, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension:.fractionalWidth(0.32))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func createDataSource() -> DataSource {
        return UICollectionViewDiffableDataSource<Int, CartItem>(collectionView: self.collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueCell(cellClass: CartCollectionViewCell.self, for: indexPath)
            
            cell.quantitySelectionView.value = item.quantity
            cell.imageView.image = UIImage(named: "tomato")
            cell.topLabel.text = "KG"
            cell.likeButton.isHidden = false
            cell.titleLabel.text = item.product.item?.name
            cell.subtitleLabel.text = "JD\(item.product.price ?? 0)"
            
            cell.quantitySelectionView.onValueChange = { [unowned self] newValue in
                self.cartManager.set(quantity: newValue, for: item.product)
                self.applySnapshot()
            }
            
            return cell
        }
    }
}
extension CartItemsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {return}
        self.router.trigger(.productDetails(item.product))
    }
}
