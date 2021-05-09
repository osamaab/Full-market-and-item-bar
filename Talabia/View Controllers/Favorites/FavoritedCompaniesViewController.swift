//
//  FavoritedCompaniesViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 15/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia
import XCoordinator
import SDWebImage

let companyFav = "Talabia.companyFav"

class FavoritedCompaniesViewController: ContentViewController<[FavouriteCompanies]> {
    
    let router: UnownedRouter<FavoritesRoute>
    lazy var collectionView: UICollectionView = configureCollectionView()
    let fav = Notification.Name(rawValue: companyFav)
    init(router: UnownedRouter<FavoritesRoute>){
        self.router = router
        super.init(contentRepository: APIContentRepositoryType<FavoritesAPI, [FavouriteCompanies]>(.companies))
    }
    var items: [FavouriteCompanies] {
    content ?? []
    }
    var selectedCategories: [FavouriteCompanies] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViewsBeforeTransitioning() {
        view.addSubview(collectionView)
        collectionView.Width == view.Width
        collectionView.Height == view.Height
        collectionView.leading(0).trailing(0).top(0).bottom(0)
        collectionView.backgroundColor = DefaultColorsProvider.containerBackground3
        collectionView.delegate = self
        collectionView.dataSource = self
        createObserver()
    }
    override func contentRequestDidSuccess(with content: [FavouriteCompanies]) {
        selectedCategories = []
        items.forEach { product in
            selectedCategories.append(product)
        }
        self.collectionView.reloadData()
    }
}
extension FavoritedCompaniesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return selectedCategories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: FavouritsCompaniesCollectionViewCell.self, for: indexPath)
        let item = selectedCategories[indexPath.item]
        cell.likeButton.isHidden = false
        cell.topLabel.isHidden = true
//        cell.imageView.image = UIImage(named: "company")
        cell.imageView.sd_setImage(with: URL(string: item.company?.logoPath ?? ""), completed: nil)
        cell.likeButton.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
        cell.likeButton.tag = indexPath.row
        cell.subtitleLabel1.text = item.company?.username ?? "Osama.Co"
        cell.likeButton.isChecked =  self.selectedCategories.contains(item)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    @objc func action(sender: UIButton){
        let index = sender.tag
        let item = selectedCategories[index]
        if self.selectedCategories.contains(item){
            self.selectedCategories.remove(at: selectedCategories.firstIndex(of: item)!)
            FavoritesAPI.unfavoriteCompany(item.company?.id ?? 0).request(String.self).catch {
                self.showMessage(message: $0.localizedDescription, messageType: .failure)
//                self.selectedCategories.remove(at: self.selectedCategories.firstIndex(of: item)!)
            }
        } else {
            self.selectedCategories.append(item)
            FavoritesAPI.favoriteCompany(item.company?.id ?? 0).request(String.self).catch {
                self.showMessage(message: $0.localizedDescription, messageType: .failure)
                self.selectedCategories.append(item)
            }
        }
    }
}

extension FavoritedCompaniesViewController {
    func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: FavouritsCompaniesCollectionViewCell.self)
        
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
            heightDimension: .fractionalWidth(0.48))
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
