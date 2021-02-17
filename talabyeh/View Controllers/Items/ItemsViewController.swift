//
//  ItemsViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 21/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

struct CategoryWithProducts {
    let category: SubCategory
    let products: [ProductTemplate]
}


class ItemsViewController: ContentViewController<[CategoryWithProducts]> {
    
    struct SampleContentProvider: ContentRepositoryType {
        typealias ContentType = [CategoryWithProducts]
        
        func requestContent(completion: @escaping ContentRequestCompletion<[CategoryWithProducts]>) {
            let categories = (0...1).map { SubCategory.sample(id: $0) }
            
            completion(.success(categories.map { cat in
                let products = (0...6).map { ProductTemplate.sample(title: "Product \($0 * (cat.id + 1))" )}
                return CategoryWithProducts(category: cat, products: products)
            }))
        }
    }
    

    typealias DataSource = UICollectionViewDiffableDataSource<SubCategory, ProductTemplate>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SubCategory, ProductTemplate>

    let titleHeaderKind = "title-header"
    
    lazy var collectionView: UICollectionView = createCollectionView(for: createLayout())
    lazy var dataSource: DataSource = createDataSource(for: collectionView)

    fileprivate var sections: [SubCategory] = []
    fileprivate var editingSections: Set<Int> = []
    
    
    override var requiresAuthentication: Bool {
        true
    }

    override func setupViewsBeforeTransitioning() {
        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
             
        view.subviewsPreparedAL {
            collectionView
        }
        
        collectionView.Top == view.safeAreaLayoutGuide.Top
        collectionView.leading(20).trailing(20)
        collectionView.Bottom == view.safeAreaLayoutGuide.Bottom
        
        collectionView.delegate = self
        collectionView.contentInset.top = 20
    }

    override func contentRequestDidSuccess(with content: [CategoryWithProducts]) {
        var snapshot = Snapshot()
    
        
        self.sections = content.map { $0.category }
        for category in content {
            snapshot.appendSections([category.category])
            snapshot.appendItems(category.products, toSection: category.category)
        }
        
        
        dataSource.apply(snapshot)
    }
}

extension ItemsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let itemID = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        
    }
}


extension ItemsViewController {
    func createDataSource(for collectionView: UICollectionView) -> DataSource {
        let dataSource =  DataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueCell(cellClass: EditableProductCollectionViewCell.self, for: indexPath)
            

            cell.imageView.image = UIImage(named: "Rectangle 232")
            cell.subtitleLabel1.text = "Red Onions"
            cell.titleLabel.text = "New era market"
            cell.subtitleLabel2.text = "JD 0.200"
            cell.isEditing = self.editingSections.contains(indexPath.section)


            return cell
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            if kind == self.titleHeaderKind {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EditableSectionCollectionReusableView.identifier, for: indexPath) as! EditableSectionCollectionReusableView
                
                view.titleLabel.text = self.sections[indexPath.section].title
                view.isEditing = self.editingSections.contains(indexPath.section)
                
                
                view.onEdit = {
                    if self.editingSections.contains(indexPath.section){
                        self.editingSections.remove(indexPath.section)
                    } else {
                        self.editingSections.insert(indexPath.section)
                    }
                    
                    
                    self.collectionView.reloadData()
                }
                
                return view
            }
            
            return nil
        }
        
        return dataSource
    }
    
    func createCollectionView(for layout: UICollectionViewLayout) -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: EditableProductCollectionViewCell.self)
        collectionView.register(EditableSectionCollectionReusableView.self, forSupplementaryViewOfKind: titleHeaderKind, withReuseIdentifier: EditableSectionCollectionReusableView.identifier)
        return collectionView
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemHeightDimension: NSCollectionLayoutDimension = .estimated(180)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                              heightDimension: itemHeightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: itemHeightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        group.interItemSpacing = .fixed(20)

        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)), elementKind: titleHeaderKind, alignment: .top)
        headerItem.contentInsets = .init(top: 15, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        section.boundarySupplementaryItems = [
            headerItem
        ]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        
        if #available(iOS 14.0, *) {
            configuration.contentInsetsReference = .safeArea
        }
        
        layout.configuration = configuration
        
        return layout
    }
}
