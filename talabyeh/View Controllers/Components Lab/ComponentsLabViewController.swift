//
//  ComponentsLabViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 01/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class ComponentsLabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.background1
        
        
//        let choices = (0..<10).map { AnyChoiceItem(title: "Item \($0)") }
//        let selectionButton = DropdownSelectionButton(choices: choices)
//        
//        selectionButton.contentEdgeInsets = .init(top: 5, left: 20, bottom: 5, right: 20)
//        selectionButton.setTitle("Items", for: .normal)
//        selectionButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addSubview(selectionButton)
//        selectionButton.centerInContainer()
        
        let button = BorderedButton()
        button.setTitle("Checkout", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = .init(top: 5, left: 20, bottom: 5, right: 20)
        
        view.addSubview(button)
        button.centerInContainer()
        
        button.addAction {
            self.navigationController?.pushViewController(PaymentCardsPickerViewController(), animated: true)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
