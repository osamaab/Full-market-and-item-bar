//
//  MarketScreenViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 11/1/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia
import XCoordinator
import FSPagerView

class MarketViewController: ContentViewController<Market>, UICollectionViewDelegate, UICollectionViewDataSource {
    
    enum MarketType {
        case full
        case company(Company)
        case category(SubCategory)
        case companyMarket(Product)
        
        var contentRepository: AnyContentRepository<Market> {
            switch self {
            case .full:
                return APIContentRepositoryType<MarketAPI, Market>(.market(10, 0)).eraseToAnyContentRepository()
            case .company(let company):
                return APIContentRepositoryType<MarketAPI, Market>(.companyMarket(company.id)).eraseToAnyContentRepository()
            case .category(let subCategory):
                return APIContentRepositoryType<MarketAPI, Market>(.categoryDetails(subCategory.id)).eraseToAnyContentRepository()
            case .companyMarket(let companyId):
                return APIContentRepositoryType<MarketAPI,Market>(.companyMarket(companyId.companyId)).eraseToAnyContentRepository()
            }
        }
    }
    
    @Injected var cartManager: CartManagerType
    
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
    
    var banners = ["banner0", "category1"]  // for test purpose :)
    
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
        collectionView.trailing(10).leading(10).bottom(0).top(10)
        if self.preferencesManager.userType == .company || self.preferencesManager.userType == .distributor {
            collectionView.contentInset = .init(top: -20, left: -20, bottom: 0, right: 0)
        } else {
            collectionView.contentInset = .init(top: 0, left: -20, bottom: 0, right: 0)
        }
//        FavoritedProductsViewController.createObserver()
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
        self.navigationItem.rightBarButtonItem =  searchItem
        
        if self.preferencesManager.userType == .company || self.preferencesManager.userType == .distributor {
            self.title = "Market"
        } else {
            setupNavigationBarleftView()
        }
        if let tabItems = self.tabBarController?.tabBar.items {
        let tabItem = tabItems[1]
        tabItem.badgeValue = "\(self.cartManager.orderedItems().count)"
            if self.cartManager.orderedItems().count == 0 {
                tabItem.badgeValue = nil
            }
            if self.preferencesManager.userType == .company || self.preferencesManager.userType == .distributor {
                tabItem.badgeValue = nil
            }
        }
    }
    
    override func contentRequestDidSuccess(with content: Market) {
        self.collectionView.reloadData()
    }
    
}

extension MarketViewController: MarketChooseLocationViewControllerDelegate {
    func marketChooseLocationViewController(sender: MarketChooseLocationViewController, didFinishWith location: DeliveryType) {
        
    }
}

extension MarketViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        !hasAnyData ? 0 : 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            if self.preferencesManager.userType == .company || self.preferencesManager.userType == .distributor {
                return 0
            }else {
                return banners.count
            }
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
            if self.preferencesManager.userType == .company || self.preferencesManager.userType == .distributor {
                let cell = collectionView.dequeueCell(cellClass: BannerCollectionViewCell.self, for: indexPath)
                return cell
            } else {
                let cell = collectionView.dequeueCell(cellClass: BannerCollectionViewCell.self, for: indexPath)
                cell.setupPagerView(items: banners)
                return cell
            }
            
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
            if DefaultAuthenticationManager.shared.isAuthenticated {
                cell.likeButton.isEnabled = true
            }else {
                cell.likeButton.isEnabled = false
            }
            cell.likeButton.addTarget(self, action: #selector(companyAction(sender:)), for: .touchUpInside)
            cell.likeButton.tag = indexPath.row
            cell.titleLabel.text = company.name
            cell.likeButton.isChecked = checkedfavaritCompany.contains(company)
            return cell
        case 3:
            let product = products[indexPath.item]
            let cell = collectionView.dequeueCell(cellClass: ProductCollectionViewCell.self, for: indexPath)
            cell.imageView.image = UIImage(named: "tomato")
            cell.subtitleLabel1.text = product.item?.name
            cell.titleLabel.text = product.companyTitle
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
                break
            case 1:
                header.titleLable.text = "All Categories"
                header.seeMoreButton.setTitle("View All", for: .normal)
                header.seeMoreButton.setImage(UIImage(named: "see_more"), for: .normal)
                header.seeMoreButton.titleEdgeInsets = .init(top: 0, left: -15, bottom: 0, right: 0)
                header.seeMoreButton.imageEdgeInsets = .init(top: 2, left: 60, bottom: 0, right: -15)
                header.seeMoreButton.addAction { [unowned self] in
                    let categories = self.preferencesManager.selectedCategories ?? []
                    let selectedSubCategories = self.preferencesManager.selectedSubCategories ?? []
                    
                    var newCategories: [MainCategory] = []
                    categories.forEach { mainCat in
                        let selectedSub = selectedSubCategories.filter { $0.categoryID == mainCat.id }
                        
                        newCategories.append(.init(id: mainCat.id, title: mainCat.title, logo: mainCat.logo, subcategories: selectedSub))
                    }
                    
                    self.router.trigger(.categories(newCategories))
                }
            case 2:
                header.titleLable.text = "New Companies"
                header.seeMoreButton.setTitle("View All", for: .normal)
                header.seeMoreButton.setImage(UIImage(named: "see_more"), for: .normal)
                header.seeMoreButton.titleEdgeInsets = .init(top: 0, left: -15, bottom: 0, right: 0)
                header.seeMoreButton.imageEdgeInsets = .init(top: 2, left: 60, bottom: 0, right: -15)
                header.seeMoreButton.addAction { [unowned self] in
                    self.router.trigger(.allCompanies)
                }
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
            self.router.trigger(.categoryDetails(categories[indexPath.item]))
            break
        case 2:
//            if DefaultAuthenticationManager.shared.isAuthenticated {
                self.router.trigger(.company(companies[indexPath.item]))
//            }else{
//                self.router.trigger(.login)
//            }
        case 3:
            self.router.trigger(.productDetails(products[indexPath.item]))
        default:
            break
        }
    }
    @objc func companyAction(sender: UIButton){
//        if DefaultAuthenticationManager.shared.isAuthenticated {
            let index = sender.tag
            let item = companies[index]
        let name = Notification.Name(rawValue: companyFav)
            if self.checkedfavaritCompany.contains(item){
                self.checkedfavaritCompany.remove(at: checkedfavaritCompany.firstIndex(of: item)!)
                self.router.trigger(.unfavoriteCompany(item))
                NotificationCenter.default.post(name: name, object: nil)
            } else {
                self.checkedfavaritCompany.append(item)
                self.router.trigger(.favoriteCompany(item))
                NotificationCenter.default.post(name: name, object: nil)
            }
            //         self.collectionView.reloadData()
            self.collectionView.reloadItems(at: [IndexPath(item: index, section: 2)])
//        }else {
//            self.router.trigger(.login)
//        }
       
    }
    @objc func productAction(sender: UIButton){
        let index = sender.tag
        let item = products[index]
        let name = Notification.Name(rawValue: productFav)
        
        
        if self.productSelectedCategories.contains(item){
            self.productSelectedCategories.remove(at: productSelectedCategories.firstIndex(of: item)!)
            
            FavoritesAPI.unfavoriteProduct(item.id).request(String.self).then { _ in
                NotificationCenter.default.post(name: name, object: nil)
            }
            .catch {
                self.showMessage(message: $0.localizedDescription, messageType: .failure)
                self.productSelectedCategories.append(item)
                self.collectionView.reloadItems(at: [IndexPath(item: index, section: 3)])
            }
            
        } else {
            self.productSelectedCategories.append(item)
//            self.router.trigger(.favoriteProduct(item))
            
            FavoritesAPI.favoriteProduct(item.id, item.totalQuantity ?? 0).request(String.self).then { _ in
                NotificationCenter.default.post(name: name, object: nil)
            }
            .catch {
                self.showMessage(message: $0.localizedDescription, messageType: .failure)

                self.productSelectedCategories.remove(at: self.productSelectedCategories.firstIndex(of: item)!)
                self.collectionView.reloadItems(at: [IndexPath(item: index, section: 3)])
            }

        }
        
        self.collectionView.reloadItems(at: [IndexPath(item: index, section: 3)])
    }
}


extension MarketViewController {
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
                if self.preferencesManager.userType == .company || self.preferencesManager.userType == .distributor {
                    let itemHeightDimension: NSCollectionLayoutDimension = .absolute(150)
                    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: itemHeightDimension)
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    
                    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.934),
                                                           heightDimension: .fractionalWidth(0.01))
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                    group.interItemSpacing = .fixed(20)
                    
                    section = NSCollectionLayoutSection(group: group)
                    section.orthogonalScrollingBehavior = .continuous
                    section.interGroupSpacing = 30
                }else {
                    let itemHeightDimension: NSCollectionLayoutDimension = .fractionalHeight(1.0)
                    
                    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: itemHeightDimension)
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    
                    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                           heightDimension: .fractionalWidth(0.35))
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                    //            group.interItemSpacing = .fixed(20)
                    
                    section = NSCollectionLayoutSection(group: group)
                    section.orthogonalScrollingBehavior = .continuous
                    
                    //            section.interGroupSpacing = 30
                }
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
            case 3:
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
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
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
}


class MarketChooseDeliveryButton: BasicViewWithSetup {
    let titleLabel = UILabel().then {
        $0.font = .font(for: .semiBold, size: 10)
        $0.textColor = DefaultColorsProvider.tintSecondary
        $0.text = "Delivery to:"
    }
    
    let button = UIButton().then {
        $0.contentEdgeInsets = .init(top: 3, left: 5, bottom: 3, right: 100)
        $0.backgroundColor = DefaultColorsProvider.tintSecondary
        $0.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        $0.setTitle("Amman 2", for: .normal)
        $0.titleLabel?.font = .font(for: .semiBold, size: 17)
    }
    
    override func setup() {
        let stackView = UIStackView()
        stackView.distribution(.fill)
            .alignment(.fill)
            .axis(.vertical)
            .spacing(3)
            .preparedForAutolayout()
        
        subviewsPreparedAL {
            stackView
        }
        
        stackView.fillContainer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.layer.cornerRadius = button.bounds.height / 2
    }
}
extension MarketViewController{
    
    
    
    
    
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
}

