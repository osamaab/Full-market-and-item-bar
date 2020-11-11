//
//  ResultsController.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import Stevia

class ResultsController : UIViewController, UISearchBarDelegate {
    
    
    let tableView = UITableView()
    let headerView = UIView()
    let searchBar = UISearchBar()
    let filterButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        tableView.backgroundColor = DefaultColorsProvider.background
        tableView.separatorStyle = .none
        tableView.isHidden =  true
        
        headerView.backgroundColor = Constants.darkGreen

        filterButton.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        filterButton.setImage(UIImage(named: "Group 2731"), for: .normal)
        
        searchBar.delegate = self
        searchBar.placeholder = "Search".localiz()
        
        searchBar.backgroundImage = UIImage()
        searchBar.textField?.backgroundColor = .white
        searchBar.textField?.layer.cornerRadius = 12
        searchBar.becomeFirstResponder()
        
        view.subviews(tableView)
        view.subviews(headerView)
        headerView.top(0).leading(0).trailing(0).height(88.11)
        tableView.bottom(0).leading(0).trailing(0)
        tableView.Top == headerView.Bottom
        
        headerView.subviews([searchBar, filterButton])
        searchBar.bottom(7.39).leading(10).trailing(56).height(37)
        filterButton.trailing(18.75).width(20).height(20)
        filterButton.CenterY == searchBar.CenterY
    }
    
    @objc func filterTapped(){
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text != ""{
            tableView.isHidden = false
        } else {
            tableView.isHidden = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.isHidden = true
    }
}



