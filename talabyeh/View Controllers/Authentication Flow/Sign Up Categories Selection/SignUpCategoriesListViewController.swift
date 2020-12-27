//
//  SignUpCategoriesListViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/14/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia
import LanguageManager_iOS
import SDWebImage

class SignUpCategoriesListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    
    let signUpCategoriesListView = SignUpCategoriesListView()
    var categories = [Category]()
    var chosenUserType: UserTypeEnum?
    
    
    override func loadView() {
        view = signUpCategoriesListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch chosenUserType! {
        case .Company:
            signUpCategoriesListView.headerImage.image = LanguageManager.shared.currentLanguage == .en ? UIImage(named: "CompanyImageEnglish") : UIImage(named: "CompanyImageArabic")
        case .Distributor:
            signUpCategoriesListView.headerImage.image = LanguageManager.shared.currentLanguage == .en ? UIImage(named: "DistributorImageEnglish") : UIImage(named: "DistributorImageArabic")
        case .Reseller:
            signUpCategoriesListView.headerImage.image = LanguageManager.shared.currentLanguage == .en ? UIImage(named: "ResellerImageEnglish") : UIImage(named: "ResellerImageArabic")
        }
        
        signUpCategoriesListView.backButton.addTarget(self, action: #selector(backButton), for: .touchUpInside)
        signUpCategoriesListView.categoriesCollectionView.delegate = self
        signUpCategoriesListView.categoriesCollectionView.dataSource = self
        signUpCategoriesListView.categoriesCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    @objc func backButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CategoryCell
        
        cell?.checkMark.image = UIImage(named: "Group 2696")
        cell?.checkMark.image = cell?.checkMark.image?.withRenderingMode(.alwaysTemplate)
        cell?.checkMark.tintColor = DefaultColorsProvider.containerBackground4
        
        if selectedIndices.contains(indexPath){
            cell?.checkMark.image = UIImage(named: "Group 2753")
        }

        
        
        return cell!
    }
    
    var selectedIndices = [IndexPath]()
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 103.67, height: 100.44)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (selectedIndices.contains(indexPath)){
            if let index = selectedIndices.firstIndex(of: indexPath){
                selectedIndices.remove(at: index)
                collectionView.reloadData()
                
            }
            return
        }
        selectedIndices.append(indexPath)
        collectionView.reloadData()
    }
}


class CategoryCell: UICollectionViewCell{
    
    let cView = UIView()
    let icon = UIImageView()
    let cTitle = UILabel()
    let checkMark = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        
        self.subviews([cView, cTitle])
        
        cView.backgroundColor = DefaultColorsProvider.containerBackground4
        cView.layer.cornerRadius = 11.75
        cView.width(100%).height(78.2).top(0)
        
        cTitle.font = LanguageManager.shared.currentLanguage == .en ? getEnglishFont(13, .semiBold): getArabicFont(13, .heavy)
        cTitle.textColor = DefaultColorsProvider.textPrimary1
        cTitle.height(15).centerHorizontally()
        cTitle.Top == cView.Bottom + 7.24
        
        cView.subviews(icon)
        cView.subviews(checkMark)
        
        icon.height(30.74).width(47.41).centerHorizontally().top(34)
        checkMark.height(22.56).width(22.56).trailing(7.56).top(7.56)

    }
    
}


