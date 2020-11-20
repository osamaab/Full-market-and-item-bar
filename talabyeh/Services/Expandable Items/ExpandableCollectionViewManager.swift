//
//  ExpandableCollectionViewManager.swift
//  ExpandableCollectionViewKit
//
//  Created by Astemir Eleev on 06/10/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import UIKit
import Combine

enum ExpandableItemType: Hashable {
    case folder(ExpandableItemFolder)
    case item(ExpandableItem)
    
    var asFolder: ExpandableItemFolder? {
        if case .folder(let f) = self {
            return f
        }
        
        return nil
    }
    
    var asItem: ExpandableItem? {
        if case .item(let i) = self {
            return i
        }
        
        return nil
    }
    
    var asExpandableItem: ExpandableItem? {
        switch self {
        case .folder(let item):
            return item
        case .item(let item):
            return item
        }
    }
}


protocol ExpandableCollectionViewManagerDelegate: class {
    
    /**
     
     */
    func expandableCollectionViewManager(_ sender: ExpandableCollectionViewManager, cellForFolderItem item: ExpandableItemFolder, at indexPath: IndexPath) -> ExpandableFolderItemCell

    /**
     
     */
    func expandableCollectionViewManager(_ sender: ExpandableCollectionViewManager, cellForItem item: ExpandableItem, at indexPath: IndexPath) -> UICollectionViewCell
    
    /**
     reports a selection of given item
     */
    func expandableCollectionViewManager(_ sender: ExpandableCollectionViewManager, didSelectItem item: ExpandableItem, isFolder: Bool, at indexPath: IndexPath)
}

final public class ExpandableCollectionViewManager: NSObject {
    
    enum Section {
        case main
    }
    
    
    /**
     The collection view
     */
    let collectionView: UICollectionView
    
    /**
     The object where the manager asks for cells and reports selection
     */
    unowned var delegate: ExpandableCollectionViewManagerDelegate
    
    /**
     Items array, including folders and subitems
     */
    var menuItems: [ExpandableItemType] = []

    private var dataSource: UICollectionViewDiffableDataSource<Section, ExpandableItemType>!
    private var diselectedIndexPath: IndexPath?
            
    init(collectionView: UICollectionView, delegate: ExpandableCollectionViewManagerDelegate){
        self.collectionView = collectionView
        self.delegate = delegate
        super.init()
        self.configure()
    }
    
    init(collectionView: UICollectionView, delegate: ExpandableCollectionViewManagerDelegate,
                items: [ExpandableItemType]) {
        self.collectionView = collectionView
        self.delegate = delegate
        super.init()
        
        appendItems(items)
        configure()
    }
    
    // MARK: - Private setup
    
    private func configure() {
        self.collectionView.delegate = self
        configureDataSource()
    }
}

extension ExpandableCollectionViewManager {
    func appendItems(_ items: [ExpandableItemType]) {
        menuItems += items
    }
    
    func appendItem(_ item: ExpandableItemType) {
        menuItems += [item]
    }
}

// MARK: - Collection View Configuration Extension
extension ExpandableCollectionViewManager {
    func updateDataSource(animatingDifferences isAnimated: Bool = true, completion: @escaping () -> Void = { }) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else { return }
            let snapshot = self.snapshotForCurrentState()
            self.dataSource.apply(snapshot, animatingDifferences: isAnimated, completion: completion)
        }
    }

    func configureDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource
        <Section, ExpandableItemType>(collectionView: collectionView) { [unowned self]
            (collectionView: UICollectionView, indexPath: IndexPath, menuItem: ExpandableItemType) -> UICollectionViewCell? in
            
            switch menuItem {
            case .folder(let folder):
                let cell = delegate.expandableCollectionViewManager(self, cellForFolderItem: folder, at: indexPath)
                cell.isGroup = folder.isGroup
                cell.isExpanded = folder.isExpanded
                return cell
            case .item(let item):
                let cell = delegate.expandableCollectionViewManager(self, cellForItem: item, at: indexPath)
                
                return cell
            }
        }
        
        // Load the initial data
        updateDataSource(animatingDifferences: false)
    }
    

    
    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, ExpandableItemType> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ExpandableItemType>()
        
        snapshot.appendSections([Section.main])
        
        func addItems(_ menuItem: ExpandableItemType) {
            snapshot.appendItems([menuItem])
            
            guard let folder = menuItem.asFolder, folder.isExpanded else { return }
            
            folder.subitems.forEach {
                if let folder = $0 as? ExpandableItemFolder {
                    addItems(.folder(folder))
                } else {
                    addItems(.item($0))
                }
            }
        }
        
        menuItems.forEach { addItems($0) }
        return snapshot
    }
}

// MARK: - Scroll View Override
extension ExpandableCollectionViewManager {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        diselectedIndexPath = nil
    }
}

// MARK: - Collection View Delegate Conformance
extension ExpandableCollectionViewManager: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let menuItem = dataSource.itemIdentifier(for: indexPath) else { return }
        collectionView.deselectItem(at: indexPath, animated: true)
        
        
        switch menuItem {
        case .folder(let folder):
            if folder.isGroup {
                folder.isExpanded.toggle()
                
                diselectedIndexPath = folder.isExpanded ? indexPath : nil
                
                if let cell = collectionView.cellForItem(at: indexPath) as? ExpandableFolderItemCell {
                    cell.isExpanded = folder.isExpanded
                    updateDataSource()
                }
            }
            break
        case .item(let item):
            self.delegate.expandableCollectionViewManager(self, didSelectItem: item, isFolder: false, at: indexPath)
            break
        }
    }
}
