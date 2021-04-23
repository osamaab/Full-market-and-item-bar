//
//  CompanyDetailsViewController.swift
//  Talabia
//
//  Created by Osama Abu hdba on 19/04/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia
import XCoordinator

class CompanyDetailsViewController: ContentViewController<Market>, UICollectionViewDelegate, UICollectionViewDataSource {
    
    enum MarketType {
        case full
        case company(Company)
        
        var contentRepository: AnyContentRepository<Market> {
            switch self {
            case .full:
                return APIContentRepositoryType<MarketAPI, Market>(.market(10, 0)).eraseToAnyContentRepository()
            case .company(let company):
                return APIContentRepositoryType<MarketAPI, Market>(.companyMarket(company.id)).eraseToAnyContentRepository()
            }
        }
    }
    
    let bannerHeaderKind = "header-banner-kind"
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
    
    var banners = ["banner0"]  // for test purpose :)
    
    var companies: [Company]  {
        content?.companies ?? []
    }
    
    var products: [Product] {
        content?.hotSellingItems ?? []
    }
    
    var hasAnyData: Bool {
        !categories.isEmpty || bannerURL != nil || !companies.isEmpty || !products.isEmpty
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
        collectionView.trailing(10).leading(10).bottom(0).top(10)
        collectionView.contentInset = .init(top: 0, left: -20, bottom: 0, right: 0)
        collectionView.register(reusableViewClass: CollectionViewSectionHeader.self, for: headerKind)
        collectionView.register(reusableViewClass: BannerViewSectionHeader.self, for: bannerHeaderKind)
        
        collectionView.register(cellClass: CompanyBannerCollectionViewCell.self)
        collectionView.register(cellClass: SubCategoryCollectionViewCell.self)
        collectionView.register(cellClass: ProductCollectionViewCell.self)
        collectionView.register(cellClass: CompanyCollectionViewCell.self)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.fillContainer()
        let searchItem = UIBarButtonItem(image: UIImage(named: "search-Icon")) {
            [unowned self] in
            self.router.trigger(.advancedSearch)
        }
        self.navigationItem.rightBarButtonItem =  searchItem
    }
    override func contentRequestDidSuccess(with content: Market) {
        self.collectionView.reloadData()
    }
}

extension CompanyDetailsViewController: MarketChooseLocationViewControllerDelegate {
    func marketChooseLocationViewController(sender: MarketChooseLocationViewController, didFinishWith location: DeliveryType) {
        
    }
}

extension CompanyDetailsViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        !hasAnyData ? 0 : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
                return 1
        case 1:
            return categories.count
        case 2:
            return products.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
        
                let cell = collectionView.dequeueCell(cellClass: CompanyBannerCollectionViewCell.self, for: indexPath)
            cell.imageView.image = UIImage(named: "banner0")
                return cell
            
        case 1:
            let category = categories[indexPath.item]
            let cell = collectionView.dequeueCell(cellClass: SubCategoryCollectionViewCell.self, for: indexPath)
            
            cell.imageView.sd_setImage(with: category.imageURL, completed: nil)
            cell.titleLabel.text = category.title
            
            return cell
        case 2:
            let product = products[indexPath.item]
            let cell = collectionView.dequeueCell(cellClass: ProductCollectionViewCell.self, for: indexPath)
            cell.imageView.image = UIImage(named: "tomato")
            cell.subtitleLabel1.text = product.item.name
            cell.titleLabel.text = product.username
            cell.topLabel.text = "1KG" //product.unit.title
            cell.subtitleLabel2.text = product.price.priceFormatted
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
                break
            case 1:
                header.titleLable.text = "All Categories"
                
                header.seeMoreButton.setTitle("View All", for: .normal)
                header.seeMoreButton.setImage(UIImage(named: "see_more"), for: .normal)
                header.seeMoreButton.titleEdgeInsets = .init(top: 0, left: -5, bottom: 0, right: 0)
                header.seeMoreButton.imageEdgeInsets = .init(top: 2, left: 70, bottom: 0, right: -15)
                header.seeMoreButton.addAction { [unowned self] in
                    self.router.trigger(.categories(self.preferencesManager.selectedCategories ?? []))
                }
            case 2:
                header.titleLable.text = "HOT SELLING ITEMS"
            default:
                break
            }
            
            return header
        } else if kind == bannerHeaderKind {
            let header = collectionView.dequeReusableView(reusableViewType: BannerViewSectionHeader.self, kind: bannerHeaderKind, for: indexPath)
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            break
        case 1:
            break
        case 2:
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
        self.collectionView.reloadItems(at: [IndexPath(item: index, section: 1)])
    }
    @objc func productAction(sender: UIButton){
        let index = sender.tag
        let item = products[index]
        if self.productSelectedCategories.contains(item){
            self.productSelectedCategories.remove(at: productSelectedCategories.firstIndex(of: item)!)
        } else {
            self.productSelectedCategories.append(item)
        }
        self.collectionView.reloadItems(at: [IndexPath(item: index, section: 2)])
    }
}


extension CompanyDetailsViewController {
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = DefaultColorsProvider.backgroundPrimary
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, enviroment) -> NSCollectionLayoutSection? in
            
            let section: NSCollectionLayoutSection
            switch sectionIndex {
            case 0:
                    let itemHeightDimension: NSCollectionLayoutDimension = .fractionalHeight(1.0)
                    
                    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: itemHeightDimension)
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    
                    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                           heightDimension: .fractionalWidth(0.35))
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                  
                    
                    section = NSCollectionLayoutSection(group: group)
                    section.orthogonalScrollingBehavior = .continuous
                    
            case 1:
                let itemHeightDimension: NSCollectionLayoutDimension = .fractionalHeight(1.0)
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                      heightDimension: itemHeightDimension)
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                item.contentInsets = .init(top: 0, leading: 10 , bottom: 0, trailing: 10)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.82), heightDimension: .fractionalWidth(0.3)), subitem: item, count: 3)
                //                group.interItemSpacing = .fixed(10)
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
            //                section.interGroupSpacing = 30
            case 2:
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
            
            
            
            // the height of the header must include the content inset ( vertical dimensions )
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: self.headerKind, alignment: .top)
            
            let boundaryItems: [NSCollectionLayoutBoundarySupplementaryItem]
            
            if sectionIndex == 0 {
                boundaryItems = []
            } else {
                boundaryItems = [header]
            }
            
            section.boundarySupplementaryItems = boundaryItems
            section.contentInsets = .init(top: 0, leading: 20, bottom: 20, trailing: -15)
            return section
        }
        
        
        return layout
    }
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    @objc func backAction(_ sender: UIButton) {
        let _ = navigationController?.popViewController(animated: true)
    }
}
