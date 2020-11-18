//
//  TestLabViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 18/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class TestLabViewController: UIViewController {
    
    let items: [ExpandableItemType] = [
        .folder(ExpandableItemFolder(title: "ToDo") {
            ExpandableItem(title: "Compose Email")
            ExpandableItem(title: "Watch Netflix")
        }),
        
        .item(ExpandableItem(title: "Buy new iPhone")),
        .item(ExpandableItem(title: "Cleanup"))
    ]
    
    lazy var collectionView: UICollectionView = configureCollectionView()
    lazy var expManager = ExpandableCollectionViewManager(collectionView: self.collectionView, delegate: self, items: self.items)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        self.view.addSubview(collectionView)
        collectionView.fillContainer()
        
        expManager.updateDataSource()
    }
    
    func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: ExpandableFolderItemCell.self)
        
        return collectionView
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let itemHeightDimension: NSCollectionLayoutDimension = .absolute(50)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: itemHeightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: itemHeightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension TestLabViewController: ExpandableCollectionViewManagerDelegate {
    func expandableCollectionViewManager(_ sender: ExpandableCollectionViewManager, cellForFolderItem item: ExpandableItemFolder, at indexPath: IndexPath) -> ExpandableFolderItemCell {
        let folderCell = sender.collectionView.dequeueCell(cellClass: ExpandableFolderItemCell.self, for: indexPath)
        
        return folderCell
    }
    
    func expandableCollectionViewManager(_ sender: ExpandableCollectionViewManager, cellForItem item: ExpandableItem, at indexPath: IndexPath) -> ExpandableFolderItemCell {
        let folderCell = sender.collectionView.dequeueCell(cellClass: ExpandableFolderItemCell.self, for: indexPath)
        
        return folderCell
    }
    
    func expandableCollectionViewManager(_ sender: ExpandableCollectionViewManager, didSelectItem item: ExpandableItem, isFolder: Bool, at indexPath: IndexPath) {
        
    }
}
