//
//  CLLabViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 18/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia


extension CLItem {
    func eraseToAnyItem() -> CLAnyItem {
        .init(item: self)
    }
}

extension Array where Element == CLItem {
    func eraseToAnyItem() -> [CLAnyItem] {
        map(CLAnyItem.init)
    }
}

/**
 Groups ->
 - Screens
 - Components
 - Constants
 */
class CLLabViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<CLAnySectionType, CLAnyItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CLAnySectionType, CLAnyItem>
    
    let sectionHeaderKind = "cats_header"
    
    lazy var collectionView: UICollectionView = createCollectionView(for: createLayout())
    lazy var dataSource: DataSource = createDataSource(for: collectionView)
    
    fileprivate(set) var sections: [CLAnySectionType] = []
    
    let screensProvider: CLScreenSectionListProvider
    let componentsProvider: CLComponentSectionListProvider
    let colorsProvider: CLColorsSectionListProvider
    
    init(screensProvider: CLScreenSectionListProvider,
         componentsProvider: CLComponentSectionListProvider,
         colorsProvider: CLColorsSectionListProvider){
        
        
        self.screensProvider = screensProvider
        self.componentsProvider = componentsProvider
        self.colorsProvider = colorsProvider
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupCollectionView()
        registerDefaultSections()
        createSnapshotAndReload()
    }
    
    func setupCollectionView(){
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
             
        view.subviewsPreparedAL {
            collectionView
        }
        
        collectionView.Top == view.safeAreaLayoutGuide.Top
        collectionView.leading(20).trailing(20)
        collectionView.Bottom == view.safeAreaLayoutGuide.Bottom
        
        collectionView.delegate = self
        collectionView.contentInset.top += 20
    }
    
    func registerDefaultSections(){
        let screensSection = CLAnySectionType(name: "Screens",
                                              items: screensProvider.sections().map { $0.eraseToAnyItem() })
        
        
        
        let componentsSection = CLAnySectionType(name: "Components",
                                                 items: componentsProvider.sections().map { $0.eraseToAnyItem() })
        
        let colorsSection = CLAnySectionType(name: "Colors", items: colorsProvider.sections().map { $0.eraseToAnyItem() })
        
        self.sections.append(screensSection)
        self.sections.append(componentsSection)
        self.sections.append(colorsSection)
    }
    
    func createSnapshotAndReload(){
        var snapshot = Snapshot()
        snapshot.appendSections(self.sections)
        
        sections.forEach {
            snapshot.appendItems($0.items, toSection: $0)
        }

        dataSource.apply(snapshot)
    }
}


extension CLLabViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // take the underlying type and compare it :)
        guard let originalItem = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        if let asScreenSection = originalItem.underlyingItem as? CLScreensSection {
            let nextVC = CLScreensListViewController(sections: [asScreenSection])
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
        if let asComponentsSection = originalItem.underlyingItem as? CLComponentsSection {
            let nextVC = CLComponentsListViewController(components: asComponentsSection.items)
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
        if let asColorsSection = originalItem.underlyingItem as? CLColorsSection {
            let nextVC = CLColorsListViewController(colorItems: asColorsSection.items)
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

extension CLLabViewController {
    func createDataSource(for collectionView: UICollectionView) -> DataSource {
        let ds = DataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueCell(cellClass: CLScreenitemCollectionViewCell.self, for: indexPath)
            cell.titleLabel.text = item.name
            cell.subtitleLabel.isHidden = true
            return cell
        }
        
        ds.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            if kind == self.sectionHeaderKind {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TintedLabelCollectionReusableView.identifier, for: indexPath) as! TintedLabelCollectionReusableView
                view.titleLabel.text = self.sections[indexPath.section].name
                return view
            }
            
            return nil
        }
        
        return ds
    }
    
    func createCollectionView(for layout: UICollectionViewLayout) -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: CLScreenitemCollectionViewCell.self)
        collectionView.register(TintedLabelCollectionReusableView.self, forSupplementaryViewOfKind: sectionHeaderKind, withReuseIdentifier: TintedLabelCollectionReusableView.identifier)

        return collectionView
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)), elementKind: sectionHeaderKind, alignment: .top)
        headerItem.contentInsets = .init(top: 15, leading: 0, bottom: 0, trailing: 0)
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        section.interGroupSpacing = 15
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
