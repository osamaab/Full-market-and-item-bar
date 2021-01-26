//
//  ItemsViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 21/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class ItemsViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<ItemsCategory, Product>
    typealias Snapshot = NSDiffableDataSourceSnapshot<ItemsCategory, Product>

    let titleHeaderKind = "title-header"
    
    lazy var collectionView: UICollectionView = createCollectionView(for: createLayout())
    lazy var dataSource: DataSource = createDataSource(for: collectionView)

    fileprivate var sections: [ItemsCategory] = []
    fileprivate var editingSections: Set<Int> = []
    
    init(sections: [ItemsCategory] = []){
        self.sections = sections
        super.init(nibName: nil, bundle: nil)
    }
    
    init(){
        self.sections = [ItemsCategory(title: "Cats")]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.background1
             
        view.subviewsPreparedAL {
            collectionView
        }
        
        collectionView.Top == view.safeAreaLayoutGuide.Top
        collectionView.leading(20).trailing(20)
        collectionView.Bottom == view.safeAreaLayoutGuide.Bottom
        
        collectionView.delegate = self
        collectionView.contentInset.top = 20
        
        setupDataAndCreateSnapshot()
    }
    
    func setupDataAndCreateSnapshot(){
        var snapshot = Snapshot()
    
        snapshot.appendSections(self.sections)
        let items = (0...9).map { Product(title: "Product \($0)") }
        snapshot.appendItems(items)
        
        
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
                
                
                print("Section: \(indexPath.section)")
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
