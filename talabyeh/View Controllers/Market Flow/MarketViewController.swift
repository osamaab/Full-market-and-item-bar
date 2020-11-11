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

class MarketViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
            cell.itemImage.image = image
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == marketView.allCategoriesCollectionViewWithTitle.collectionView{
            return CGSize(width: 92.12, height: 92.12 + 9.57 + 13)
            
        } else if collectionView == marketView.itemsCollectionView1.collectionView{
            return CGSize(width: 120.15, height: 130.16 + 6.78 + 14 + 4.39 + 13)
        } else {
            return CGSize(width: 120.15, height: 130.16)
        }
    }
    
    
    @objc func searchTapped(){
        let resultsController = ResultsController()
        resultsController.modalTransitionStyle = .crossDissolve
        resultsController.modalPresentationStyle = .overFullScreen
        self.present(resultsController, animated: true, completion: nil)
    }
}

