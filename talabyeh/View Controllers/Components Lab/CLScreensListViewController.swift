//
//  CLScreensListViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 18/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia


extension CLScreensSection {
    static let defaultAll = CLScreensSection(name: "All", items: CLScreenItem.getAllAvailable())
}

class CLScreensListViewController: UIViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<CLScreensSection, CLScreenItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CLScreensSection, CLScreenItem>
    
    lazy var collectionView: UICollectionView = createCollectionView(for: createLayout())
    lazy var dataSource: DataSource = createDataSource(for: collectionView)


    fileprivate var sections: [CLScreensSection] = []
    
    
    init(sections: [CLScreensSection]){
        self.sections = sections
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
        
        setupDataAndCreateSnapshot()
    }
    
    func setupDataAndCreateSnapshot(){
        var snapshot = Snapshot()
        snapshot.appendSections(self.sections)
        
        sections.forEach {
            snapshot.appendItems($0.items, toSection: $0)
        }

        dataSource.apply(snapshot)
    }
}

extension CLScreensListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let itemID = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        guard let screen = itemID.getScreen() else {
            return
        }
        
        self.navigationController?.pushViewController(screen, animated: true)
    }
}

extension CLScreensListViewController {
    func createDataSource(for collectionView: UICollectionView) -> DataSource {
        return DataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueCell(cellClass: CLScreenitemCollectionViewCell.self, for: indexPath)
            cell.titleLabel.text = item.name
            cell.subtitleLabel.text = item.path
            cell.subtitleLabel.isHidden = item.path?.isEmpty ?? true || item.path == nil
            
            return cell
        }
    }
    
    func createCollectionView(for layout: UICollectionViewLayout) -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: CLScreenitemCollectionViewCell.self)
        return collectionView
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        section.interGroupSpacing = 15
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        if #available(iOS 14.0, *) {
            configuration.contentInsetsReference = .safeArea
        }
        
        layout.configuration = configuration
        
        return layout
    }
}
