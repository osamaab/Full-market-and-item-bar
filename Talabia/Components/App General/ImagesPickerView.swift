//
//  ImagesPickerView.swift
//  talabyeh
//
//  Created by Hussein Work on 21/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

/**
 A view that enables multiple image picking
 */
class ImagesPickerView: UIView {
    enum Item {
        case image(UIImage)
        case placeholder
    }
    
    fileprivate var items: [Item]
    fileprivate var placeholderIndexPath: IndexPath?
    
    fileprivate(set) lazy var collectionView: UICollectionView = createCollectionView(for: createLayout())
    
    fileprivate var imagePicker: ImagePickerController?
    
    var images: [UIImage] {
        items.compactMap {
            if case .image(let image) = $0 {
                return image
            }
            
            return nil
        }
    }
    
    
    init(images: [UIImage] = []){
        self.items = images.map { .image($0) } + [.placeholder]
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        subviewsPreparedAL {
            collectionView
        }
        
        collectionView.fillContainer()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.reloadData()
    }
}

extension ImagesPickerView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.items[indexPath.item]
        
        switch item {
        case .image(let image):
            let imageCell = collectionView.dequeueCell(cellClass: ImageCollectionViewCell.self, for: indexPath)
            imageCell.imageView.image = image
            
            return imageCell
        case .placeholder:
            let placeholderCell = collectionView.dequeueCell(cellClass: PlaceholderCollectionViewCell.self, for: indexPath)
            
            return placeholderCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.items[indexPath.item]
        let cell = collectionView.cellForItem(at: indexPath)
        
        if case .placeholder = item {
            placeholderIndexPath = indexPath
            
            // fire an image picker
            if let topViewController = UIApplication.topViewController() {
                imagePicker = ImagePickerController(presentationController: topViewController,
                                      delegate: self)
                imagePicker?.present(from: cell ?? self)
            }
        }
    }
}

extension ImagesPickerView: ImagePickerControllerDelegate {
    func imagePickerController(_ sender: ImagePickerController, didFinishWith image: UIImage?) {
        guard let image = image else {
            return
        }
        
        if let placeholderIndexPath = self.placeholderIndexPath {
            self.items.insert(.image(image), at: placeholderIndexPath.item)
        } else {
            self.items.append(.image(image))
        }
        
        self.collectionView.reloadData()
    }
}

extension ImagesPickerView {
    func createCollectionView(for layout: UICollectionViewLayout) -> UICollectionView {
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: ImageCollectionViewCell.self)
        collectionView.register(cellClass: PlaceholderCollectionViewCell.self)

        return collectionView
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 15
        
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        if #available(iOS 14.0, *) {
            configuration.contentInsetsReference = .safeArea
        }
        
        layout.configuration = configuration
        
        return layout
    }
}

private class PlaceholderCollectionViewCell: UICollectionViewCell {
    
    let pickerView = PickerPlaceholderView(title: "Pictures", image: UIImage(named: "camera"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        layer.cornerRadius = 10
        clipsToBounds = true

        
        subviewsPreparedAL {
            pickerView
        }
        
        pickerView.titleLabel.font = .font(for: .regular, size: 16)
        pickerView.fillContainer()
    }
}

private class ImageCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        layer.cornerRadius = 10
        clipsToBounds = true
        
        subviewsPreparedAL {
            imageView
        }
        
        imageView.fillContainer()
        imageView.contentMode = .scaleAspectFill
    }
}
