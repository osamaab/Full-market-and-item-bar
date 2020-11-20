//
//  ExpandableItem.swift
//  ExpandableCollectionViewKit
//
//  Created by Astemir Eleev on 06/10/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import UIKit

/// Base class for the expandable items. Don't use this class to fill in the expandable table view, since it's not inended to be used in that way.
public class ExpandableItem: Hashable {
        
    let identifier = UUID().uuidString
    
    weak var parent: ExpandableItem? = nil

    init(){ }
    
    public init(parent: ExpandableItem) {
        self.parent = parent
    }
    
    public init(parent: ExpandableItem,
                indentLevel: Int) {
        self.parent = parent
    }
        
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    public static func == (lhs: ExpandableItem, rhs: ExpandableItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

extension ExpandableItem {
    @discardableResult
    func setParent(_ parent: ExpandableItem) -> Self {
        self.parent = parent
        return self
    }
}

extension Array where Element == ExpandableItem {
    func setParent(_ parent: ExpandableItem){
        forEach {
            $0.setParent(parent)
        }
    }
}

extension Array where Element == ExpandableItem {
    func flatten() -> [ExpandableItem] {
        var originalArray: [ExpandableItem] = []
        
        for item in self {
            if let folder = item as? ExpandableItemFolder {
                let subArray = folder.subitems.flatten()
                originalArray.append(contentsOf: subArray)
            } else {
                originalArray.append(item)
            }
        }

        return  originalArray
    }
}
