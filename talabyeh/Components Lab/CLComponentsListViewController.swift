//
//  CLComponentsListViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 24/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CLComponentsListViewController: UIViewController {

    lazy var collectionView: UICollectionView = createCollectionView(for: createLayout())
    
    let components: [CLComponentItem]
    
    init(components: [CLComponentItem]){
        self.components = components
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
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension CLComponentsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        components.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: CLScreenitemCollectionViewCell.self, for: indexPath)
        let previewType = self.components[indexPath.item]
        cell.titleLabel.text = previewType.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let component = components[indexPath.item]
        
        let previewContext = CLDefaultCardComponentContext(componentPreview: component.previewComponent)
        let nextViewController = previewContext.render()
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

extension CLComponentsListViewController {
    func createCollectionView(for layout: UICollectionViewLayout) -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: CLScreenitemCollectionViewCell.self)
        return collectionView
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
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
