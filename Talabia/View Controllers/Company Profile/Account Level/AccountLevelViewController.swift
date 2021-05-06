//
//  AccountLevelViewController.swift
//  Talabia
//
//  Created by Osama Abu hdba on 05/05/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia
class AccountLevelViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = configureCollectionView()
    
    var headers: [String] = ["New in the market","Biggener","Verified"]
    var items: [String] = ["Full Information about the company","Items area full of products","You have Distributor","You did more than 100 order in good condition"]
    static let headerElementKind = "header"
    
    let topTitile = UILabel().then{
        $0.font = .font(for: .bold, size: 17)
        $0.textAlignment = .left
        $0.textColor = UIColor(hex: "#9AA1B1")
        $0.text = "Levels"
    }
    
    lazy var bottomView: BottomNextButtonView = .init(title: "Next")
    var selectedItems: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Account level"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), action: {            self.navigationController?.popViewController(animated: true)
        })
//        view.addSubview(collectionView)
//        view.addSubview(topTitile)
        view.subviewsPreparedAL{
            topTitile
            collectionView
            bottomView
        }
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
//        topTitile.Top == view.safeAreaLayoutGuide.Bottom + 10
        topTitile.top(20)
        topTitile.height(20)
        topTitile.leading(25)

        collectionView.contentInset.top = 10
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bottom(0).leading(7).trailing(7)
        collectionView.Top == topTitile.Bottom
        collectionView.reloadData()
        bottomView.leading(0).trailing(0).bottom(0)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        headers.count
    }

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    items.count
}
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueCell(cellClass: AccountLevelCollectionViewCell.self, for: indexPath)
    let item = items[indexPath.item]
    cell.titleLabel.text = item
//    if indexPath == indexPath {
//        cell.checkbox.isSelected = true
//    }
    cell.checkbox.isSelected = selectedItems.contains(item)
    return cell
}
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == Self.headerElementKind else {
            return .init()
        }
        
        
        let header = collectionView.dequeReusableView(reusableViewType: AccountLevelCollectionReusableView.self, kind: Self.headerElementKind, for: indexPath)
        let category = self.headers[indexPath.section]
        
        header.titleLabel.text = category
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        if self.selectedItems.contains(item){
            self.selectedItems.remove(at: selectedItems.firstIndex(of: item)!)
        } else {
            self.selectedItems.append(item)
        }
       
        self.collectionView.reloadItems(at: [indexPath])
    }
}
extension AccountLevelViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(reusableViewClass: AccountLevelCollectionReusableView.self, for: Self.headerElementKind)
        collectionView.register(cellClass: AccountLevelCollectionViewCell.self)
        return collectionView
    }
    
    func generateLayout() -> UICollectionViewLayout {
//
        let itemSize = NSCollectionLayoutSize(
           widthDimension: .fractionalWidth(1.0),
           heightDimension: .fractionalHeight(1.0))
         let ItemSpace = NSCollectionLayoutItem(layoutSize: itemSize)
        ItemSpace.contentInsets = NSDirectionalEdgeInsets(
          top: 0,
          leading: 0,
          bottom: 0,
          trailing: 0)
         //2
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.07))
         let group = NSCollectionLayoutGroup.horizontal(
           layoutSize: groupSize,
           subitem: ItemSpace,
           count: 1)
         let section = NSCollectionLayoutSection(group: group)
        
        let boundaryItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                      heightDimension: .estimated(30))
        let boundaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: boundaryItemSize,
                                                                       elementKind: Self.headerElementKind,
                                                                       alignment: .top)
        section.boundarySupplementaryItems = [
            boundaryItem
        ]
        
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
