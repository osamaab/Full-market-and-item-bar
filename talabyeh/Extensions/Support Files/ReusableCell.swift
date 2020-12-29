//
//  ReusableCell.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

protocol ReusableCell: Identifiable {
    
}

extension UITableViewCell: ReusableCell {
    
}

extension UICollectionViewCell: ReusableCell {
    
}

extension UITableView {
    func register(cellClass: ReusableCell.Type){
        register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }
    
    func register(cellNib: ReusableCell.Type){
        register(UINib(nibName: cellNib.identifier, bundle: nil), forCellReuseIdentifier: cellNib.identifier)
    }
    
    func dequeueCell<T: ReusableCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}


extension UICollectionView {
    func register(cellClass: ReusableCell.Type){
        register(cellClass, forCellWithReuseIdentifier: cellClass.identifier)
    }
    
    func register(cellNib: ReusableCell.Type){
        register(UINib(nibName: cellNib.identifier, bundle: nil), forCellWithReuseIdentifier: cellNib.identifier)
    }
    
    func dequeueCell<T: ReusableCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}

protocol EmptyInstantiatable {
    static func instantiate() -> Self
}
