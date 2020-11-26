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
            CategorySearchFieldType(placeholder: "Category")
        }),
        
        .folder(ExpandableItemFolder(title: "Distributer") {
            TextSearchFieldType(placeholder: "Distributor name")
            LocationSearchFieldType(placeholder: "Covering area")
            CategorySearchFieldType(placeholder: "Category")
        }),
        
        .folder(ExpandableItemFolder(title: "Company") {
            TextSearchFieldType(placeholder: "Company Name")
            LocationSearchFieldType(placeholder: "Company Location")
            CategorySearchFieldType(placeholder: "Category")
        })
    ]
    
    lazy var bottomView: BottomNextButtonView = .init(title: "Search")
    lazy var collectionView: UICollectionView = configureCollectionView()
    lazy var expManager = ExpandableCollectionViewManager(collectionView: self.collectionView, delegate: self, items: self.items)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Search"
        view.backgroundColor = DefaultColorsProvider.background
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(collectionView)
        collectionView.fillContainer()
        
        self.view.addSubview(bottomView)
        bottomView.bottom(0).leading(0).trailing(0)
        
        items.compactMap { $0.asExpandableItem }.flatten().compactMap { $0 as? SearchFieldType }.forEach {
            collectionView.register(cellClass: cellClass(for: $0))
        }
        
        expManager.updateDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.contentInset.bottom = bottomView.bounds.height + 20
    }

    /**
     Given a search field type, this method checks the sub type of the field ( text, location, ... ) and deques a new cell with customizing it's values
     */
    func dequeConfiguredCell(for searchFieldType: SearchFieldType, at indexPath: IndexPath) -> UICollectionViewCell {
        if let asLocation = searchFieldType as? LocationSearchFieldType {
            let cell = collectionView.dequeueCell(cellClass: AdvancedSearchItemCollectionViewCell<LocationPickerTextField>.self, for: indexPath)

            cell.textField.location = asLocation.location
            cell.textField.placeholder = asLocation.placeholder
            cell.onValueChange = {
                asLocation.location = $0.location
            }
            
            return cell
        }
        
        if let asText = searchFieldType as? TextSearchFieldType {
            let cell = collectionView.dequeueCell(cellClass: AdvancedSearchItemCollectionViewCell<ValidationTextField>.self, for: indexPath)
            
            cell.textField.placeholder = searchFieldType.placeholder
            cell.textField.text = asText.text
            cell.onValueChange = {
                asText.text = $0.text
            }
            
            return cell
        }
        
        if let asCategory = searchFieldType as? CategorySearchFieldType {
            let cell =  collectionView.dequeueCell(cellClass: AdvancedSearchItemCollectionViewCell<CategoryPickerTextField>.self, for: indexPath)
            
            cell.textField.placeholder = searchFieldType.placeholder
            cell.textField.categories = asCategory.categories
            cell.onValueChange = {
                asCategory.categories = $0.categories
            }
            
            return cell
        }
        
        fatalError("Unsupported search type")
    }
    
    func cellClass(for item: SearchFieldType) -> ReusableCell.Type {
        switch item {
        case is LocationSearchFieldType:
            return AdvancedSearchItemCollectionViewCell<LocationPickerTextField>.self
        case is TextSearchFieldType:
            return AdvancedSearchItemCollectionViewCell<ValidationTextField>.self
        case is CategorySearchFieldType:
            return AdvancedSearchItemCollectionViewCell<CategoryPickerTextField>.self
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
        
        let cell = dequeConfiguredCell(for: asSearchType, at: indexPath)
        return cell
    }
    
    func expandableCollectionViewManager(_ sender: ExpandableCollectionViewManager, didSelectItem item: ExpandableItem, isFolder: Bool, at indexPath: IndexPath) {
        
    }
}

extension AdvancedSearchViewController {
    func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .clear
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



