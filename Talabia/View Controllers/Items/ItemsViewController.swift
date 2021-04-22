//
//  ItemsViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 21/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia
import XCoordinator

struct CategoryWithProducts {
    let category: SubCategory
    let products: [Product]
}
protocol ItemsViewControllerDelegate: class {
    func authenticationCoordinator(_ sender: ItemsViewController)
}

class ItemsViewController: ContentViewController<[CategoryWithProducts]> {
    
    let category: SubCategory
    struct DefaultContentRepositoryType: ContentRepositoryType {
        typealias ContentType = [CategoryWithProducts]
        
        let category: SubCategory
        let api: ItemsAPI
        
        init(category: SubCategory, api: ItemsAPI){
            self.category = category
            self.api = api
        }
        
         func requestContent(completion: @escaping ContentRequestCompletion<[CategoryWithProducts]>) {
            APIContentRepositoryType<ItemsAPI, [Product]>(api).requestContent { (result) in
                switch result {
                case .success(let products):
                    let includedProducts = products.filter { $0.item.subcategoryID == category.id }
                    completion(.success([CategoryWithProducts(category: self.category, products: includedProducts)]))
                    return
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    typealias DataSource = UICollectionViewDiffableDataSource<SubCategory, Product>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SubCategory, Product>

    weak var delegate: ItemsViewControllerDelegate?
    
    let titleHeaderKind = "title-header"
    
    lazy var collectionView: UICollectionView = createCollectionView(for: createLayout())
    lazy var dataSource: DataSource = createDataSource(for: collectionView)

    fileprivate var sections: [SubCategory] = []
    fileprivate var editingSections: Set<Int> = []
    
    
    var allowsEditing: Bool = true
    
   
    
    
    var router: UnownedRouter<ItemsRoute>
    
    init<R: ContentRepositoryType>(router: UnownedRouter<ItemsRoute>, contentRepository: R, category: SubCategory) where R.ContentType == ContentType {
        self.router = router
        self.category = category
        super.init(contentRepository: contentRepository)
    }
    
    init(router: UnownedRouter<ItemsRoute>, category: SubCategory, api: ItemsAPI = .marketProducts, delegate: ItemsViewControllerDelegate?){
        self.router = router
        self.delegate = delegate
        self.category = category
        super.init(contentRepository: DefaultContentRepositoryType(category: category, api: api))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setupViewsBeforeTransitioning() {
        // Do any additional setup after loading the view.
        title = "Items"
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        addBackButton() 
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
        
        if allowsEditing {
            let newBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusTapped))
            self.navigationItem.rightBarButtonItem = newBarItem
        }
        
        dataSource.apply(snapshot)
        collectionView.reloadData()
    }
    
    @objc func plusTapped(){
        if let content = self.content, let firstCat = content.first?.category {
            router.trigger(.newItem(firstCat))
        }
    }
}

extension ItemsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.router.trigger(.details(dataSource.itemIdentifier(for: indexPath)!, category))
    }
}


extension ItemsViewController {
    func createDataSource(for collectionView: UICollectionView) -> DataSource {
        let dataSource =  DataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueCell(cellClass: EditableProductCollectionViewCell.self, for: indexPath)
            

            cell.imageView.image = UIImage(named: "Rectangle 232")
            cell.subtitleLabel1.text = item.item.name
            cell.titleLabel.text = ""//item.username
            cell.subtitleLabel2.text = "\(item.price) JD"
            cell.topLabel.text = "1KG"//item.unit.title
            cell.isEditing = self.editingSections.contains(indexPath.section)
//            cell.imageView.sd_setImage(with: item.images.first?.url, completed: nil)
            cell.imageView.image = UIImage(named: "tomato")
            
            cell.likeButton.alpha = 0
            cell.onRemoveButtonTap = { [unowned self] in
                self.router.trigger(.remove(item))
            }
            
            return cell
        }
        
        
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            if kind == self.titleHeaderKind {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EditableSectionCollectionReusableView.identifier, for: indexPath) as! EditableSectionCollectionReusableView
                
                view.titleLabel.text = self.sections[indexPath.section].title
                view.isEditing = self.editingSections.contains(indexPath.section)
                view.editButton.isHidden = !self.allowsEditing
                
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

extension ItemsViewController: NewProductQuantityViewControllerDelegate{
    func newProductQuantityViewController(_ sender: NewProductQuantityViewController, didFinishWith form: NewProductQuantityViewController.NewQuantityForm) {

        requestContent { _ in}
    }
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.setTitle("Category", for: .normal)
        backButton.titleEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -15)
        backButton.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        backButton.titleLabel?.font = .font(for: .bold, size: 17)
        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    @objc func backAction(_ sender: UIButton) {
        let _ = navigationController?.popViewController(animated: true)
    }

}
