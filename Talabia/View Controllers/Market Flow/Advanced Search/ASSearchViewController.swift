//
//  ASSearchViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 18/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

class ASSearchViewController: UIViewController {

    
    
    enum CurrentSearchType {
        case items
        case companies
    }

    let items: [ExpandableItemType] = [
        .folder(ExpandableItemFolder(title: "Item") {
            TextSearchFieldType(placeholder: "Item Name")
            CategorySearchFieldType(placeholder: "Category")
        }),
        
//        .folder(ExpandableItemFolder(title: "Distributer") {
//            TextSearchFieldType(placeholder: "Distributor name")
//            LocationSearchFieldType(placeholder: "Covering area")
//            CategorySearchFieldType(placeholder: "Category")
//        }),
        
        .folder(ExpandableItemFolder(title: "Company") {
            TextSearchFieldType(placeholder: "Company Name")
            LocationSearchFieldType(placeholder: "Company Location")
            CategorySearchFieldType(placeholder: "Category")
        })
    ]
    
    lazy var bottomView: BottomNextButtonView = .init(title: "Search")
    lazy var collectionView: UICollectionView = configureCollectionView()
    lazy var expManager = ExpandableCollectionViewManager(collectionView: self.collectionView, delegate: self, items: self.items)
    
    fileprivate var currentSearchType: CurrentSearchType?
    
    var router: UnownedRouter<AdvancedSearchRoute>
    
    init(router: UnownedRouter<AdvancedSearchRoute>) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Search"
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
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
        
        bottomView.nextButton.add(event: .touchUpInside) { [unowned self] in
            self.performSearch()
        }
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
            let cell = collectionView.dequeueCell(cellClass: ASItemCollectionViewCell<CityPickerTextField>.self, for: indexPath)

            cell.textField.city = asLocation.city
            cell.textField.placeholder = asLocation.placeholder
            cell.onValueChange = {
                asLocation.city = $0.city
            }
            
            return cell
        }
        
        if let asText = searchFieldType as? TextSearchFieldType {
            let cell = collectionView.dequeueCell(cellClass: ASItemCollectionViewCell<ValidationTextField>.self, for: indexPath)
            
            cell.textField.placeholder = searchFieldType.placeholder
            cell.textField.text = asText.text
            cell.onValueChange = {
                asText.text = $0.text
            }
            
            return cell
        }
        
        if let asCategory = searchFieldType as? CategorySearchFieldType {
            let cell =  collectionView.dequeueCell(cellClass: ASItemCollectionViewCell<CategoryPickerTextField>.self, for: indexPath)
            
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
            return ASItemCollectionViewCell<CityPickerTextField>.self
        case is TextSearchFieldType:
            return ASItemCollectionViewCell<ValidationTextField>.self
        case is CategorySearchFieldType:
            return ASItemCollectionViewCell<CategoryPickerTextField>.self
        default:
            fatalError("Unsupported  search type")
        }
    }
    
    func performSearch(){
        guard let currentSearch = self.currentSearchType else {
            print("Must choose a search type")
            return
        }
        
        /*
         Depending on the current search type, we want to get the search items and get their values.
         */
        if currentSearch == .companies {
            if case .folder(let folder) = self.items[1] {
                let subitems = folder.subitems
            
                let name = subitems.compactMap { $0 as? TextSearchFieldType }.first?.text
                let location = subitems.compactMap { $0 as? LocationSearchFieldType }.first?.city
                let category = subitems.compactMap { $0 as? CategorySearchFieldType }.first?.categories.first
                
                print("Submitting a company search query, parameters: \(name), \(location), \(category)")
                self.router.trigger(.searchCompanies(.init(name: name, category: category, city: location)))
            }
        } else if currentSearch == .items {
            if case .folder(let folder) = self.items[0] {
                let subitems = folder.subitems
            
                let name = subitems.compactMap { $0 as? TextSearchFieldType }.first?.text
                let category = subitems.compactMap { $0 as? CategorySearchFieldType }.first?.categories.first
                
                print("Submitting a item search query, parameters: \(name), \(category)")
                self.router.trigger(.searchItems(.init(name: name, category: category)))
            }
        }
    }
}

extension ASSearchViewController: ExpandableCollectionViewManagerDelegate {
    func expandableCollectionViewManager(_ sender: ExpandableCollectionViewManager, cellForFolderItem item: ExpandableItemFolder, at indexPath: IndexPath) -> ExpandableFolderItemCell {
        let cell = collectionView.dequeueCell(cellClass: ASFolderCollectionViewCell.self, for: indexPath)
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
        
        if isFolder {
            if let asFolder = item as? ExpandableItemFolder {
                if asFolder.title == "Item", asFolder.isExpanded {
                    currentSearchType = .items
                } else if asFolder.title == "Company", asFolder.isExpanded {
                    currentSearchType = .companies
                }
            }
        }
    }
}

extension ASSearchViewController {
    func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(cellClass: ASFolderCollectionViewCell.self)
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



