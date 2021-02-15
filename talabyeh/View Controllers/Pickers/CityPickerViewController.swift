//
//  CityPickerViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 07/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

protocol CityPickerViewControllerDelegate: class {
    func cityPickerViewController(_ sender: CityPickerViewController, didFinishWith options: [CityItem])
}

class CityPickerViewController: ContentViewController<[CityItem]> {
    
    enum SelectionMode {
        case single
        case multiple
    }
    
    lazy var collectionView: UICollectionView = createCollectionView()
    lazy var labelView: LabelView = .init(title: "City", icon: UIImage(named: "delivery_area"))
    lazy var bottomSaveView: BottomNextButtonView = .init(title: "Save")
    
    var selectedOptions: Set<CityItem> = []
    var selectionMode: SelectionMode = .multiple
    
    weak var delegate: CityPickerViewControllerDelegate?
    
    convenience init(){
        self.init(contentRepository: APIContentRepositoryType<GeneralAPI, [CityItem]>(.areas))
    }
    
    override func setupViewsBeforeTransitioning() {
        
        view.subviewsPreparedAL { () -> [UIView] in
            labelView
            collectionView
            bottomSaveView
        }
        
        labelView.Top == view.safeAreaLayoutGuide.Top + 25
        labelView.leading(20).trailing(20)
        
        collectionView.leading(0).trailing(0)
        collectionView.Top == labelView.Bottom
        
        bottomSaveView.bottom(0).leading(0).trailing(0)
        bottomSaveView.Top == collectionView.Bottom
        
        bottomSaveView.nextButton.add(event: .touchUpInside){ [unowned self] in
            self.delegate?.cityPickerViewController(self, didFinishWith: Array(selectedOptions))
        }
    }
    
    override func contentRequestDidSuccess(with content: [CityItem]) {
        collectionView.reloadData()
    }
}

extension CityPickerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        content?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: OptionCollectionViewCell.self, for: indexPath)
        let item = unwrappedContent[indexPath.item]
        
        cell.titleLabel.text = item.title
        cell.checkbox.isSelected = selectedOptions.contains(item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = unwrappedContent[indexPath.item]
        
        if self.selectionMode == .single {
            self.selectedOptions.removeAll()
            self.selectedOptions.insert(item)
        } else {
            if selectedOptions.contains(item) {
                self.selectedOptions.remove(item)
            } else {
                self.selectedOptions.insert(item)
            }
        }
        
        self.collectionView.reloadData()
    }
}

extension CityPickerViewController {
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createCollectionViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: OptionCollectionViewCell.self)
        return collectionView
    }
    
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let itemHeightDimension: NSCollectionLayoutDimension = .absolute(50)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: itemHeightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: itemHeightDimension)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)

        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
