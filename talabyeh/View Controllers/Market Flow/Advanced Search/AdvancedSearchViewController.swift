//
//  AdvancedSearchViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 18/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class AdvancedSearchViewController: UIViewController {

    let items: [ExpandableItemType] = [
        .folder(ExpandableItemFolder(title: "Items") {
            TextSearchFieldType(placeholder: "Item Name")
            CategoryPickerFieldType(placeholder: "Category")
        }),
        
        .folder(ExpandableItemFolder(title: "Distributer") {
            TextSearchFieldType(placeholder: "Distributor name")
            LocationSearchFieldType(placeholder: "Covering area")
            CategoryPickerFieldType(placeholder: "Category")
        }),
        
        .folder(ExpandableItemFolder(title: "Company") {
            TextSearchFieldType(placeholder: "Company Name")
            LocationSearchFieldType(placeholder: "Company Location")
            CategoryPickerFieldType(placeholder: "Category")
        })
    ]
    
    lazy var collectionView: UICollectionView = configureCollectionView()
    lazy var expManager = ExpandableCollectionViewManager(collectionView: self.collectionView, delegate: self, items: self.items)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        self.view.addSubview(collectionView)
        collectionView.fillContainer()
        
        items.compactMap { $0.asExpandableItem }.flatten().compactMap { $0 as? SearchFieldType }.forEach {
            collectionView.register(cellClass: cellClass(for: $0))
        }
        
        expManager.updateDataSource()
    }

    func dequeCell(for searchFieldType: SearchFieldType, at indexPath: IndexPath) -> UICollectionViewCell {
        switch searchFieldType {
        case is LocationSearchFieldType:
            let cell = collectionView.dequeueCell(cellClass: AdvancedSearchItemCollectionViewCell<LocationPickerTextField>.self, for: indexPath)
            cell.textField.placeholder = searchFieldType.placeholder
            
            return cell
        case is TextSearchFieldType:
            let cell = collectionView.dequeueCell(cellClass: AdvancedSearchItemCollectionViewCell<ValidationTextField>.self, for: indexPath)
            cell.textField.placeholder = searchFieldType.placeholder
            return cell
        default:
            fatalError("Unsupported search type")
        }
    }
    
    func cellClass(for item: SearchFieldType) -> ReusableCell.Type {
        switch item {
        case is LocationSearchFieldType:
            return AdvancedSearchItemCollectionViewCell<LocationPickerTextField>.self
        case is TextSearchFieldType:
            return AdvancedSearchItemCollectionViewCell<ValidationTextField>.self
        default:
            fatalError("Unsupported  search type")
        }
    }
}

extension AdvancedSearchViewController: ExpandableCollectionViewManagerDelegate {
    func expandableCollectionViewManager(_ sender: ExpandableCollectionViewManager, cellForFolderItem item: ExpandableItemFolder, at indexPath: IndexPath) -> ExpandableFolderItemCell {
        let cell = collectionView.dequeueCell(cellClass: AdvancedSearchFolderCollectionViewCell.self, for: indexPath)
        cell.title = item.title
        return cell
    }
    
    func expandableCollectionViewManager(_ sender: ExpandableCollectionViewManager, cellForItem item: ExpandableItem, at indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let asSearchType = item as? SearchFieldType else {
            fatalError("expandable items without conforming to search field type is not supported.")
        }
        
        let cell = dequeCell(for: asSearchType, at: indexPath)
        return cell
    }
    
    func expandableCollectionViewManager(_ sender: ExpandableCollectionViewManager, didSelectItem item: ExpandableItem, isFolder: Bool, at indexPath: IndexPath) {
        
    }
}

extension AdvancedSearchViewController {
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
        item.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: itemHeightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.interItemSpacing = .fixed(15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        section.interGroupSpacing = 15
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}



