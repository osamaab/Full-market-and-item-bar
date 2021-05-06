//
//  CategoryDetailsViewController.swift
//  Talabia
//
//  Created by Osama Abu hdba on 18/04/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia
import XCoordinator

class CategoryDetailsViewController: ContentViewController<Market>, UICollectionViewDelegate, UICollectionViewDataSource {
    
    enum MarketType {
        case full
        case company(Company)
        case category(SubCategory)
        
        var contentRepository: AnyContentRepository<Market> {
            switch self {
            case .full:
                return APIContentRepositoryType<MarketAPI, Market>(.market(10, 0)).eraseToAnyContentRepository()
            case .company(let company):
                return APIContentRepositoryType<MarketAPI, Market>(.companyMarket(company.id)).eraseToAnyContentRepository()
            case .category(let subCategory):
                return APIContentRepositoryType<MarketAPI, Market>(.categoryDetails(subCategory.id)).eraseToAnyContentRepository()
            }
        }
    }
    let headerKind = "header-kind"
    
    lazy var collectionView: UICollectionView = createCollectionView()
    let DileveryleftButton = CHDeliveryLocationCardView()
    let marketType: MarketType
    let router: UnownedRouter<MarketRoute>
    let preferencesManager = UserDefaultsPreferencesManager.shared
    
    var checkedfavaritCompany: [Company] = []
    var checkedFavaritProducts: [Product] = []
    var selectedDeliveryType: DeliveryType?
    var productSelectedCategories: [Product] = []
    
    var categories: [SubCategory] {
        content?.subcategories ?? []
    }
    
    var bannerURL: URL? {
        content?.bannerURL
    }
    
    
    var companies: [Company]  {
        content?.companies ?? []
    }
    
    var products: [Product] {
        content?.hotSellingItems ?? []
    }
    
    init(router: UnownedRouter<MarketRoute>,
         market: MarketType){
        self.router = router
        self.marketType = market
        
        super.init(contentRepository: market.contentRepository)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setupViewsBeforeTransitioning() {
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        view.addSubview(collectionView)
        addBackButton()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.trailing(10).leading(10).bottom(0).top(0)
            collectionView.contentInset = .init(top: 10, left: -15, bottom: 0, right: 0)
        collectionView.register(reusableViewClass: CollectionViewSectionHeader.self, for: headerKind)
        
        let searchItem = UIBarButtonItem(image: UIImage(named: "search-Icon")) {
            [unowned self] in
            self.router.trigger(.advancedSearch)
        }
        self.navigationItem.rightBarButtonItem =  searchItem
        
        collectionView.register(cellClass: BannerCollectionViewCell.self)
        collectionView.register(cellClass: SubCategoryCollectionViewCell.self)
        collectionView.register(cellClass: ProductCollectionViewCell.self)
        collectionView.register(cellClass: CompanyCollectionViewCell.self)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.fillContainer()
    }
    
    override func contentRequestDidSuccess(with content: Market) {
        self.collectionView.reloadData()
    }
}

extension CategoryDetailsViewController: MarketChooseLocationViewControllerDelegate {
    func marketChooseLocationViewController(sender: MarketChooseLocationViewController, didFinishWith location: DeliveryType) {
        
    }
}

extension CategoryDetailsViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return companies.count
        case 1:
            return products.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let company = companies[indexPath.item]
            let cell = collectionView.dequeueCell(cellClass: CompanyCollectionViewCell.self, for: indexPath)
//            cell.imageView.sd_setImage(with: company.imageURL)
            cell.imageView.image = UIImage(named: "company")
            cell.likeButton.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
            cell.likeButton.tag = indexPath.row
            cell.titleLabel.text = company.name
            cell.likeButton.isChecked = checkedfavaritCompany.contains(company)
            return cell
        case 1:
            let product = products[indexPath.item]
            let cell = collectionView.dequeueCell(cellClass: ProductCollectionViewCell.self, for: indexPath)
            cell.imageView.image = UIImage(named: "tomato")
            cell.subtitleLabel1.text = product.item?.name
            cell.titleLabel.text = product.username
            cell.topLabel.text = "1KG" //product.unit.title
            cell.subtitleLabel2.text = product.price?.priceFormatted
            cell.likeButton.addTarget(self, action: #selector(productAction(sender:)), for: .touchUpInside)
            cell.likeButton.tag = indexPath.row
            cell.likeButton.isChecked = productSelectedCategories.contains(product)
            return cell
        default:
            fatalError()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == headerKind {
            let header = collectionView.dequeReusableView(reusableViewType: CollectionViewSectionHeader.self, kind: headerKind, for: indexPath)
            
            header.seeMoreButton.titleLabel?.font = .font(for: .regular, size: 17)
            switch indexPath.section {
            case 0:
                header.titleLable.text = "Companies"
                header.seeMoreButton.setTitle("View All", for: .normal)
                header.seeMoreButton.setImage(UIImage(named: "see_more"), for: .normal)
                header.seeMoreButton.titleEdgeInsets = .init(top: 0, left: -15, bottom: 0, right: 0)
                header.seeMoreButton.imageEdgeInsets = .init(top: 2, left: 60, bottom: 0, right: -15)
                header.seeMoreButton.addAction { [unowned self] in
                    self.router.trigger(.allCompanies)
                }
            case 1:
                header.titleLable.text = "HOT SELLING ITEMS"
            default:
                break
            }
            
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if DefaultAuthenticationManager.shared.isAuthenticated {
                self.router.trigger(.company(companies[indexPath.item]))
            }else{
                self.router.trigger(.login)
            }
        case 1:
            self.router.trigger(.productDetails(products[indexPath.item]))
        default:
            break 
        }
    }
    @objc func action(sender: UIButton){
        let index = sender.tag
        let item = companies[index]
        if self.checkedfavaritCompany.contains(item){
            self.checkedfavaritCompany.remove(at: checkedfavaritCompany.firstIndex(of: item)!)
        } else {
            self.checkedfavaritCompany.append(item)
        }
        //         self.collectionView.reloadData()
        self.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }
    @objc func productAction(sender: UIButton){
        let index = sender.tag
        let item = products[index]
        if self.productSelectedCategories.contains(item){
            self.productSelectedCategories.remove(at: productSelectedCategories.firstIndex(of: item)!)
        } else {
            self.productSelectedCategories.append(item)
        }
        //        self.collectionView.reloadData()
        self.collectionView.reloadItems(at: [IndexPath(item: index, section: 1)])
    }
}


extension CategoryDetailsViewController {
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = DefaultColorsProvider.backgroundPrimary
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
   private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, enviroment) -> NSCollectionLayoutSection? in
            
            let section: NSCollectionLayoutSection
            switch sectionIndex {
            case 0:
                let itemHeightDimension: NSCollectionLayoutDimension = .fractionalHeight(1.0)
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: itemHeightDimension)
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 0 , bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalWidth(0.35))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
                group.interItemSpacing = .fixed(20)
                
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 15
                section.orthogonalScrollingBehavior = .continuous
            case 1:
                let itemHeightDimension: NSCollectionLayoutDimension = .estimated(130)
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                      heightDimension: itemHeightDimension)
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 0 , bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: itemHeightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
                group.interItemSpacing = .fixed(20)
                
                
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 15
            default:
                fatalError("No more than 4 sections are supported in the market layout")
            }
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: self.headerKind, alignment: .top)
            
            let boundaryItems: [NSCollectionLayoutBoundarySupplementaryItem]
                boundaryItems = [header]
        
            section.boundarySupplementaryItems = boundaryItems
            section.contentInsets = .init(top: 0, leading: 20, bottom: 20, trailing: -15)
            return section
        }
        
        
        return layout
    }
    private func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    @objc func backAction(_ sender: UIButton) {
        let _ = navigationController?.popViewController(animated: true)
    }
}
