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
            ExpandableItem()
            ExpandableItem()
        }),
        
        .item(ExpandableItem()),
        .item(ExpandableItem())
    ]
    
    lazy var collectionView: UICollectionView = configureCollectionView()
    lazy var expManager = ExpandableCollectionViewManager(collectionView: self.collectionView, delegate: self, items: self.items)
    
    var pickerController: CategoryPickerController?
    
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
        collectionView.register(cellClass: AdvancedSearchFolderCollectionViewCell.self)
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
        let folderCell = sender.collectionView.dequeueCell(cellClass: AdvancedSearchFolderCollectionViewCell.self, for: indexPath)
        return folderCell
    }
    
    func expandableCollectionViewManager(_ sender: ExpandableCollectionViewManager, cellForItem item: ExpandableItem, at indexPath: IndexPath) -> UICollectionViewCell {
        let folderCell = sender.collectionView.dequeueCell(cellClass: AdvancedSearchFolderCollectionViewCell.self, for: indexPath)
        
        
        
        return folderCell
    }
    
    func expandableCollectionViewManager(_ sender: ExpandableCollectionViewManager, didSelectItem item: ExpandableItem, isFolder: Bool, at indexPath: IndexPath) {

    }
}
