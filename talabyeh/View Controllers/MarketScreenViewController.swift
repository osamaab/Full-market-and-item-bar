//
//  MarketScreenViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 11/1/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import LanguageManager_iOS
import Stevia

class MarketScreenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    
    let marketView = MarketScreenView()
    
    let allCategoriesimages = ["dummy2","dummy3","dummy4","dummy1"]
    let allCategoriesNames = ["Meat","Poultry", "Fruit", "Frozen"]
    let itemsImages = ["Rectangle 230","Rectangle 231","Rectangle 232"]
    let companyImages = ["Rectangle 234","Rectangle 235","Rectangle 238"]
    
    
    
    override func loadView() {
        view = marketView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        marketView.headerLabel.text = "Market".localiz()
        marketView.allCategoriesCollectionViewWithTitle.titleLable.text = "All Categories".localiz()
        marketView.allCategoriesCollectionViewWithTitle.titleLable.font = LanguageManager.shared.currentLanguage == .en ? getEnglishFont(17, .medium): getArabicFont(17, .regular)
        marketView.allCategoriesCollectionViewWithTitle.seeMoreButton.setTitle("View All >".localiz(), for: .normal)
        marketView.allCategoriesCollectionViewWithTitle.seeMoreButton.titleLabel?.font = LanguageManager.shared.currentLanguage == .en ? getEnglishFont(12, .semiBold): getArabicFont(12, .heavy)
        marketView.allCategoriesCollectionViewWithTitle.collectionView.delegate = self
        marketView.allCategoriesCollectionViewWithTitle.collectionView.dataSource = self
        marketView.allCategoriesCollectionViewWithTitle.collectionView.register(MarketCategoryCell.self, forCellWithReuseIdentifier: "Cell")
        
        marketView.itemsCollectionView1.titleLable.text = "Deals in the market".localiz()
        marketView.itemsCollectionView1.titleLable.font = LanguageManager.shared.currentLanguage == .en ? getEnglishFont(17, .medium): getArabicFont(17, .regular)
        marketView.itemsCollectionView1.seeMoreButton.setTitle("View All >".localiz(), for: .normal)
        marketView.itemsCollectionView1.seeMoreButton.titleLabel?.font = LanguageManager.shared.currentLanguage == .en ? getEnglishFont(12, .semiBold): getArabicFont(12, .heavy)
        marketView.itemsCollectionView1.collectionView.delegate = self
        marketView.itemsCollectionView1.collectionView.dataSource = self
        marketView.itemsCollectionView1.collectionView.register(ItemCell.self, forCellWithReuseIdentifier: "Cell2")
        
        marketView.itemCollectionView2.titleLable.text = "New Companies".localiz()
        marketView.itemCollectionView2.titleLable.font = LanguageManager.shared.currentLanguage == .en ? getEnglishFont(17, .semiBold): getArabicFont(17, .heavy)
        marketView.itemCollectionView2.seeMoreButton.setTitle("View All >".localiz(), for: .normal)
        marketView.itemCollectionView2.seeMoreButton.titleLabel?.font = LanguageManager.shared.currentLanguage == .en ? getEnglishFont(12, .semiBold): getArabicFont(12, .heavy)
        marketView.itemCollectionView2.collectionView.delegate = self
        marketView.itemCollectionView2.collectionView.dataSource = self
        marketView.itemCollectionView2.collectionView.register(ItemCell2.self, forCellWithReuseIdentifier: "Cell3")
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == marketView.allCategoriesCollectionViewWithTitle.collectionView{
            return allCategoriesNames.count
            
        }else if collectionView == marketView.itemsCollectionView1.collectionView{
            return itemsImages.count
        }else{
            return companyImages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == marketView.allCategoriesCollectionViewWithTitle.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MarketCategoryCell
            let image = UIImage(named: allCategoriesimages[indexPath.row])
            //cell.cImage.contentMode = .scaleAspectFit
            cell.cImage.image = image
            cell.cTitle.text = allCategoriesNames[indexPath.row]
            return cell
            
        }else if collectionView == marketView.itemsCollectionView1.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! ItemCell
            let image = UIImage(named: itemsImages[indexPath.row])
            cell.itemImage.image = image
            cell.weightLabel.text = "1 KG"
            cell.itemSeller.text = "Abwab Alsalam"
            cell.itemTitle.text = "Item Title"
            cell.itemPrice.text = "JD 1.0"
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell3", for: indexPath) as! ItemCell2
            let image = UIImage(named: companyImages[indexPath.row])
            //image = image?.withRenderingMode(.alwaysTemplate)
            cell.itemImage.image = image
            //cell.itemImage.tintColor = .white
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == marketView.allCategoriesCollectionViewWithTitle.collectionView{
            return CGSize(width: 92.12, height: 92.12 + 9.57 + 13)
            
        }else if collectionView == marketView.itemsCollectionView1.collectionView{
            return CGSize(width: 120.15, height: 130.16 + 6.78 + 14 + 4.39 + 13)
        }else{
            return CGSize(width: 120.15, height: 130.16)
        }
    }
    



}



class MarketCategoryCell: UICollectionViewCell{
    
    let cImage = UIImageView()
    let cTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        
        self.subviews([cImage, cTitle])
        
        
        cImage.width(100%).height(92.12).top(0)
        
        cTitle.font = LanguageManager.shared.currentLanguage == .en ? getEnglishFont(11, .semiBold): getArabicFont(11, .heavy)
        cTitle.textColor = UIColor(named: AdaptiveColors.black.rawValue)
        cTitle.height(15).centerHorizontally()
        cTitle.Top == cImage.Bottom + 9.57
        
        cImage.layer.cornerRadius = 15
        cImage.clipsToBounds = true
        
        


    }
    
}


class ItemCell: UICollectionViewCell{
    
    let cView = UIView()
    let itemImage = UIImageView()
    let itemSeller = UILabel()
    let likeButton = UIButton()
    let weightLabel = UILabel()
    
    let itemTitle = UILabel()
    let itemPrice = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        
        self.subviews([cView, itemTitle, itemPrice])
        
        cView.backgroundColor = UIColor.systemBackground
        cView.layer.borderWidth = 0.2
        cView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cView.layer.cornerRadius = 0.91
        cView.leading(0).trailing(0).top(0).height(130.16).centerHorizontally()
        
        // cView
        cView.subviews([itemImage, itemSeller, likeButton, weightLabel])
        itemImage.contentMode = .scaleAspectFit
        itemImage.width(100%).height(84.73).top(18.71).centerHorizontally()
        itemSeller.font = LanguageManager.shared.currentLanguage == .en ? getEnglishFont(12, .medium): getArabicFont(12, .regular)
        itemSeller.textColor = UIColor(named: AdaptiveColors.green.rawValue)
        itemSeller.height(14).centerHorizontally()
        itemSeller.Top == itemImage.Bottom + 5.5
        
        weightLabel.backgroundColor = UIColor(named: AdaptiveColors.darkGrey.rawValue)
        weightLabel.textColor = UIColor(named: AdaptiveColors.white.rawValue)
        weightLabel.layer.cornerRadius = 1.7
        weightLabel.font = LanguageManager.shared.currentLanguage == .en ? getEnglishFont(9, .bold): getArabicFont(9, .bold)
        weightLabel.textAlignment = .center
        weightLabel.leading(8).top(8).height(15).width(28.27)
        
        likeButton.setImage(UIImage(named: "heart"), for: .normal)
        likeButton.contentMode = .scaleAspectFit
        likeButton.trailing(8).height(17.92).width(20.03)
        likeButton.CenterY == weightLabel.CenterY
        //
        
        itemTitle.font = LanguageManager.shared.currentLanguage == .en ? getEnglishFont(12, .medium): getArabicFont(12, .regular)
        itemTitle.textColor = UIColor(named: AdaptiveColors.black.rawValue)
        itemTitle.height(14).leading(0)
        itemTitle.Top == cView.Bottom + 6.78
        
        itemPrice.font = LanguageManager.shared.currentLanguage == .en ? getEnglishFont(11, .bold): getArabicFont(11, .bold)
        itemPrice.textColor = UIColor(named: AdaptiveColors.black.rawValue)
        itemPrice.height(13).leading(0)
        itemPrice.Top == itemTitle.Bottom + 4.39
        
        
        


    }
    
}


class ItemCell2: UICollectionViewCell{
    
    let cView = UIView()
    let itemImage = UIImageView()
    let likeButton = UIButton()


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        
        self.subviews([cView,])
        
        cView.backgroundColor = UIColor.systemBackground
        cView.layer.borderWidth = 0.2
        cView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cView.layer.cornerRadius = 0.91
        cView.leading(0).trailing(0).top(0).height(130.16).centerHorizontally()
        
        // cView
        cView.subviews([itemImage, likeButton])
        itemImage.contentMode = .scaleAspectFit
        itemImage.image = itemImage.image?.withRenderingMode(.alwaysTemplate)
        itemImage.tintColor = UIColor(named: AdaptiveColors.white.rawValue)
        itemImage.width(100%).top(20.66).bottom(9.73).centerHorizontally()

        
        likeButton.setImage(UIImage(named: "heart"), for: .normal)
        likeButton.contentMode = .scaleAspectFit
        likeButton.trailing(8).height(17.92).width(20.03).top(7.23)
        //

        
        
        


    }
    
}
