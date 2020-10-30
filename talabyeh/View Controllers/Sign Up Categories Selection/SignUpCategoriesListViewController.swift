//
//  SignUpCategoriesListViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/14/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import Stevia
import LanguageManager_iOS
import SDWebImage
import ProgressHUD

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
        
        ProgressHUD.show()
        RequestManger.shared.getCategories { (categories, error) in
            if error != nil{
                print(error.debugDescription)
                return
            }
            self.categories.removeAll()
            self.categories = categories!.results
            self.signUpCategoriesListView.categoriesCollectionView.reloadData()
            
            ProgressHUD.dismiss()
        }
        
    }
    
    @objc func backButton()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
//    let cview = UIView()
//    let icon = UIImageView()
//    let ctitle = UILabel()
//    let checkMark = UIImageView()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CategoryCell
        
        cell?.cTitle.text = categories[indexPath.row].title//LanguageManager.shared.currentLanguage == .en ? categories[indexPath.row].en_title: categories[indexPath.row].ar_title //"Title".localiz()

        
        if let url = URL(string:categories[indexPath.row].logo!){
            print(url)
            //icon.sd_setImage(with: url, placeholderImage: nil, options: .fromCacheOnly, context: nil) //= UIImage(named: "Group 2729")
            cell?.icon.contentMode = .scaleAspectFit
            cell?.icon.sd_setImage(with: url) { (image, error, cacheType, url) in
                cell?.icon.image = image?.withRenderingMode(.alwaysTemplate)
                cell?.icon.tintColor = UIColor(named: AdaptiveColors.darkGrey.rawValue)
            }
        }
        
        
        cell?.checkMark.image = UIImage(named: "Group 2696")
        cell?.checkMark.image = cell?.checkMark.image?.withRenderingMode(.alwaysTemplate)
        cell?.checkMark.tintColor = UIColor(named: AdaptiveColors.darkGrey.rawValue)
        
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
        
        cView.backgroundColor = UIColor(named: AdaptiveColors.lightGrey.rawValue)
        cView.layer.cornerRadius = 11.75
        cView.width(100%).height(78.2).top(0)
        
        cTitle.font = LanguageManager.shared.currentLanguage == .en ? getEnglishFont(13, .semiBold): getArabicFont(13, .heavy)
        cTitle.textColor = UIColor(named: AdaptiveColors.black.rawValue)
        cTitle.height(15).centerHorizontally()
        cTitle.Top == cView.Bottom + 7.24
        
        cView.subviews(icon)
        cView.subviews(checkMark)
        
        icon.height(30.74).width(47.41).centerHorizontally().top(34)
        checkMark.height(22.56).width(22.56).trailing(7.56).top(7.56)

    }
    
}


