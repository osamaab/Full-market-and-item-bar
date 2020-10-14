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

class SignUpCategoriesListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    
    let signUpCategoriesListView = SignUpCategoriesListView()
    
    override func loadView() {
        view = signUpCategoriesListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpCategoriesListView.backButton.addTarget(self, action: #selector(backButton), for: .touchUpInside)
        signUpCategoriesListView.categoriesCollectionView.delegate = self
        signUpCategoriesListView.categoriesCollectionView.dataSource = self
        signUpCategoriesListView.categoriesCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    
    @objc func backButton()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let view = UIView()
        let icon = UIImageView()
        let title = UILabel()
        let checkMark = UIImageView()
        
        cell.subviews([view, title])
        
        view.backgroundColor = Constants.lightGrey
        view.layer.cornerRadius = 11.75
        view.width(100%).height(78.2).top(0)
        
        title.text = "Title".localiz()
        title.font = LanguageManager.shared.currentLanguage == .en ? getEnglishFont(13, .semiBold): getArabicFont(13, .heavy)
        title.textColor = Constants.blackText
        title.height(15).centerHorizontally()
        title.Top == view.Bottom + 7.24
        
        view.subviews(icon)
        view.subviews(checkMark)
        
        icon.image = UIImage(named: "Group 2729")

        icon.height(30.74).width(47.41).centerHorizontally().top(34)
        
        checkMark.image = UIImage(named: "Group 2696")
        if selectedIndexPath != nil{
            if selectedIndexPath! == indexPath{
                checkMark.image = UIImage(named: "Group 2753")
            }
        }
        checkMark.height(22.56).width(22.56).trailing(7.56).top(7.56)
        
        return cell
    }
    
    var selectedIndexPath : IndexPath?
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 103.67, height: 100.44)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        collectionView.reloadData()
    }
    

}
