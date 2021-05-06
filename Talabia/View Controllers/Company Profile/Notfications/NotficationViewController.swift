//
//  NotficationViewController.swift
//  Talabia
//
//  Created by Osama Abu hdba on 05/05/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class NotficationViewController: UIViewController {

    lazy var collectionView: UICollectionView = configureCollectionView()
    var items: [String] = ["LsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjads","LsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjahdsLsdjadfhjads"] // For Test Purpose
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notifications"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), action: {            self.navigationController?.popViewController(animated: true)
        })
        view.addSubview(collectionView)
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary

        collectionView.contentInset.top = 20
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.top(0).bottom(0).leading(7).trailing(7)
    }

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    items.count
}
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueCell(cellClass: NotficationCollectionViewCell.self, for: indexPath)
    let item = items[indexPath.item]
    cell.titleLabel.text = item
    return cell
}
}
extension NotficationViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(cellClass: NotficationCollectionViewCell.self)
        return collectionView
    }
    
    func generateLayout() -> UICollectionViewLayout {
//
        let itemSize = NSCollectionLayoutSize(
           widthDimension: .fractionalWidth(1.0),
           heightDimension: .fractionalHeight(1.0))
         let ItemSpace = NSCollectionLayoutItem(layoutSize: itemSize)
        ItemSpace.contentInsets = NSDirectionalEdgeInsets(
          top: 5,
          leading: 0,
          bottom: 5,
          trailing: 0)
         //2
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.45))
         let group = NSCollectionLayoutGroup.horizontal(
           layoutSize: groupSize,
           subitem: ItemSpace,
           count: 1)
         let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .none
//        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 35, trailing: 0)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
