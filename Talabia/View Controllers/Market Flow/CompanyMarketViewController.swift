//
//  CompanyMarketViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 02/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia
import XCoordinator

class CompanyMarketViewController: ContentViewController<Market>, UICollectionViewDelegate, UICollectionViewDataSource {
    
    enum MarketType {
        case full
        case company(Company)
        
        var contentRepository: AnyContentRepository<Market> {
            switch self {
            case .full:
                return APIContentRepositoryType<MarketAPI, Market>(.market(5, 0)).eraseToAnyContentRepository()
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
    
    
    var selectedDeliveryType: DeliveryType?
    
    var categories: [SubCategory] {
        content?.subcategories ?? []
    }
    
    var bannerURL: URL? {
        content?.bannerURL
    }
    
    var banners = ["banner0", "category1"]  // for test purpose
    
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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: -40, left: -7, bottom: 0, right: 0)

        collectionView.register(reusableViewClass: CollectionViewSectionHeader.self, for: headerKind)
        collectionView.register(reusableViewClass: BannerViewSectionHeader.self, for: bannerHeaderKind)
        
        collectionView.register(cellClass: BannerCollectionViewCell.self)
        collectionView.register(cellClass: SubCategoryCollectionViewCell.self)
        collectionView.register(cellClass: ProductCollectionViewCell.self)
        collectionView.register(cellClass: CompanyCollectionViewCell.self)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.fillContainer()
        let searchItem = UIBarButtonItem(image: UIImage(named: "search-Icon")) {
            [unowned self] in
                self.router.trigger(.advancedSearch)
        }

        
        if self.preferencesManager.userType == .company || self.preferencesManager.userType == .distributor {
            self.title = "Market"
        } else {
            setupNavigationBarleftView()
        }
        self.navigationItem.rightBarButtonItem =  searchItem
    }
    
    override func contentRequestDidSuccess(with content: Market) {
        self.collectionView.reloadData()
    }
}

extension CompanyMarketViewController: MarketChooseLocationViewControllerDelegate {
    func marketChooseLocationViewController(sender: MarketChooseLocationViewController, didFinishWith location: DeliveryType) {
        
    }
}

extension CompanyMarketViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        !hasAnyData ? 0 : 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return banners.count
        case 1:
            return categories.count
        case 2:
            return companies.count
        case 3:
            return products.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueCell(cellClass: BannerCollectionViewCell.self, for: indexPath)
            cell.setupPagerView(items: banners)
//            cell.segmentedControl.addTarget(self, action: #selector(suitDidChange), for: .valueChanged)
//            if #available(iOS 14.0, *) {
//                cell.segmentedControl.actionForSegment(at: 0)
//                cell.imageView.image = UIImage(named: "\(ban)")
//            } else {
                // Fallback on earlier versions
//            }

//            cell.imageView.image = UIImage(named: "\(ban)")

            return cell
        case 1:
            let category = categories[indexPath.item]
            let cell = collectionView.dequeueCell(cellClass: SubCategoryCollectionViewCell.self, for: indexPath)
            
            cell.imageView.sd_setImage(with: category.imageURL, completed: nil)
            cell.titleLabel.text = category.title
            
            return cell
        case 2:
            let company = companies[indexPath.item]
            let cell = collectionView.dequeueCell(cellClass: CompanyCollectionViewCell.self, for: indexPath)
            
            cell.imageView.sd_setImage(with: company.imageURL)
            cell.titleLabel.text = company.name
            
            return cell
        case 3:
            let product = products[indexPath.item]
            let cell = collectionView.dequeueCell(cellClass: ProductCollectionViewCell.self, for: indexPath)
            
//            cell.imageView.sd_setImage(with: product.images.first?.url)
            cell.imageView.image = UIImage(named: "tomato")
            cell.subtitleLabel1.text = product.item.name
            cell.titleLabel.text = product.username
            cell.topLabel.text = product.unit.title
            cell.subtitleLabel2.text = product.price.priceFormatted
            
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
                header.seeMoreButton.titleEdgeInsets = .init(top: 0, left: -15, bottom: 0, right: 0)
                header.seeMoreButton.imageEdgeInsets = .init(top: 2, left: 60, bottom: 0, right: -15)
            case 2:
                header.titleLable.text = "New Companies"
                header.seeMoreButton.setTitle("View All", for: .normal)
                header.seeMoreButton.setImage(UIImage(named: "see_more"), for: .normal)
                header.seeMoreButton.titleEdgeInsets = .init(top: 0, left: -15, bottom: 0, right: 0)
                header.seeMoreButton.imageEdgeInsets = .init(top: 2, left: 60, bottom: 0, right: -15)
            case 3:
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
            // select category to filter
            break
        case 2:
            // open company market for this company
            break
        case 3:
            // open a product details
            // but right now there are not products, so no triggers will be triggered
            break
        default:
            break
        }
    }
}


extension CompanyMarketViewController {
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
                if self.preferencesManager.userType == .company{
                    let itemHeightDimension: NSCollectionLayoutDimension = .absolute(0)
                    
                    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.94),
                                                          heightDimension: itemHeightDimension)
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    
                    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .fractionalWidth(0.27))
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                    group.interItemSpacing = .fixed(5)
                    
                    section = NSCollectionLayoutSection(group: group)
                    section.orthogonalScrollingBehavior = .groupPaging
                    section.interGroupSpacing = 4
                }else{
                    let itemHeightDimension: NSCollectionLayoutDimension = .absolute(135)
                    
                    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.94),
                                                          heightDimension: itemHeightDimension)
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    
                    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .fractionalWidth(0.27))
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                    group.interItemSpacing = .fixed(5)
                    
                    section = NSCollectionLayoutSection(group: group)
                    section.orthogonalScrollingBehavior = .groupPaging
                    section.interGroupSpacing = 4
                }
            case 1:
                let itemHeightDimension: NSCollectionLayoutDimension = .absolute(130)
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(90),
                                                      heightDimension: itemHeightDimension)
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = itemSize
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(15)
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 20
            case 2:
                let itemHeightDimension: NSCollectionLayoutDimension = .absolute(130)
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                      heightDimension: itemHeightDimension)
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: itemHeightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
                group.interItemSpacing = .fixed(20)

                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 15
                section.orthogonalScrollingBehavior = .continuous
            case 3:
                let itemHeightDimension: NSCollectionLayoutDimension = .estimated(180)
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                      heightDimension: itemHeightDimension)
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
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
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: self.headerKind, alignment: .top)
            
            let boundaryItems: [NSCollectionLayoutBoundarySupplementaryItem]
            
            if sectionIndex == 0 {
//                let bannerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
//              let bannerHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: bannerHeaderSize, elementKind: self.bannerHeaderKind, alignment: .top)
               
                    boundaryItems = [header]
            } else {
                boundaryItems = [header]
            }
            
            section.boundarySupplementaryItems = boundaryItems
            section.contentInsets = .init(top: 0, leading: 20, bottom: 20, trailing: 20)
            return section
        }
        
        
        return layout
    }
}

extension CompanyMarketViewController{
    private func setupNavigationBarleftView(){
        let deliveryToView = UIView(
            frame: CGRect.init(
                x: 0,
                y: 0,
                width: 200,
                height: 40))
        let stackView = UIStackView()
        stackView
            .alignment(.leading)
            .axis(.vertical)
            .spacing(0)
            .preparedForAutolayout()
        deliveryToView.addSubview(stackView)
        stackView.fillContainer()
        let deliverToButton = UIButton(type: .custom)
        deliverToButton.setTitle("Amman 2", for: .normal)
        deliverToButton.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        deliverToButton.backgroundColor = DefaultColorsProvider.tintSecondary
        deliverToButton.titleLabel?.font = .font(for: .bold, size: 17)
        deliverToButton.setImage(UIImage(named: "three_dots"), for: .normal)
        deliverToButton.titleEdgeInsets = .init(
            top: -10,
            left: -80,
            bottom: 0,
            right: 0)
        deliverToButton.imageEdgeInsets = .init(
            top: 0,
            left: 110,
            bottom: 1,
            right: -70)
        deliverToButton.layer.cornerRadius = 11
        deliverToButton.add(event: .touchUpInside) { [weak self] in
            self?.router.trigger(.chooseStoreLocation(selected: self?.selectedDeliveryType, delegate: self!))
        }
        deliverToButton.contentEdgeInsets = .init(
            top: 0,
            left: 7,
            bottom: -8,
            right: 35)
        let buttonTitle = UIButton(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 62,
                height: 15)).then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setTitle("Delivery to:", for: .normal)
            $0.titleLabel?.font = .font(for: .regular, size: 13)
            $0.setTitleColor(.white, for: .normal)
            $0.isUserInteractionEnabled = false
            $0.titleEdgeInsets = .init(
                top: 0,
                left: 0,
                bottom: 0,
                right: -8)
            $0.contentEdgeInsets = .init(
                top: 0,
                left: 0,
                bottom: 1,
                right: 0)
        }
        stackView.addArrangedSubview(buttonTitle)
        stackView.addArrangedSubview(deliverToButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: deliveryToView)
    }
//    @objc func suitDidChange(_ segmantedControll: UISegmentedControl) {
//        switch segmantedControll.selectedSegmentIndex {
//        case 0:
//            UIImage(named: "\(Banners[0])")
//        case 1:
//            UIImage(named: "\(Banners[1])")
//        default:
//            break
//        }
    }

