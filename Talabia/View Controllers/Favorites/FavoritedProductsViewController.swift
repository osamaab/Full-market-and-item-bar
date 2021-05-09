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

let productFav = "Talabia.productFav"

class FavoritedProductsViewController: ContentViewController<[Product]> {
    
    let router: UnownedRouter<FavoritesRoute>
    let fav = Notification.Name(rawValue: productFav)
    lazy var collectionView: UICollectionView = configureCollectionView()
    init(router: UnownedRouter<FavoritesRoute>){
        self.router = router
        super.init(contentRepository: APIContentRepositoryType<FavoritesAPI, [Product]>(.products))
    }
    var items: [Product] {
    content ?? []
    }
    var selectedCategories: [Product] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func setupViewsBeforeTransitioning() {
        view.addSubview(collectionView)
        collectionView.Width == view.Width
        collectionView.Height == view.Height
        collectionView.leading(0).trailing(0).top(0).bottom(0)
        collectionView.backgroundColor = DefaultColorsProvider.containerBackground3
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.reloadData()
        createObserver()
        
    }
    override func contentRequestDidSuccess(with content: [Product]) {
        selectedCategories = []
        items.forEach { product in
            selectedCategories.append(product)
        }
        self.collectionView.reloadData()
    }
}
extension FavoritedProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return selectedCategories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: FavoritsProductCollectionViewCell.self, for: indexPath)
        let item = selectedCategories[indexPath.item]
        cell.likeButton.isHidden = false
        
        cell.imageView.image = UIImage(named: "tomato")
        cell.topLabel.text = "KG"
        cell.onFavoriteButtonTapped = { [unowned self] in
            self.favoriteAndUnfavorite(item: item)
        }
        cell.likeButton.tag = indexPath.row
        cell.likeButton.isChecked =  self.selectedCategories.contains(item)
        cell.subtitleLabel1.text = item.itemName ?? "tomato"
        cell.subtitleLabel2.text = item.price?.priceFormatted ?? "22JD"
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func favoriteAndUnfavorite(item: Product){
        if self.selectedCategories.contains(item){
            self.selectedCategories.remove(at: selectedCategories.firstIndex(of: item)!)
            FavoritesAPI.unfavoriteProduct(item.useritemid!).request(String.self).catch {
                self.showMessage(message: $0.localizedDescription, messageType: .failure)
                self.selectedCategories.remove(at: self.selectedCategories.firstIndex(of: item)!)
            }
        } else {
            self.selectedCategories.append(item)
            FavoritesAPI.favoriteProduct(item.useritemid!, item.totalQuantity ?? 0).request(String.self).catch {
                self.showMessage(message: $0.localizedDescription, messageType: .failure)
                self.selectedCategories.append(item)
            }
        }
    }
}

extension FavoritedProductsViewController {
    func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: FavoritsProductCollectionViewCell.self)
        
        return collectionView
    }
    
    func generateLayout() -> UICollectionViewLayout {
        //1
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let ItemSpace = NSCollectionLayoutItem(layoutSize: itemSize)
        ItemSpace.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 8,
            bottom: 10,
            trailing: 8)
        //2
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.52))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: ItemSpace,
            count: 3)
        group.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        //3
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
        
    }
    private func createObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTheView), name: fav, object: nil)
    }
    @objc func reloadTheView(notification: NSNotification) {
        self.retry()
    }
}
