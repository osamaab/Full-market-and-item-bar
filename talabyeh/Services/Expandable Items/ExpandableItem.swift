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
        
    var title: String
    let identifier = UUID()
    
    weak var parent: ExpandableItem? = nil

    // MARK: - Initializers
    
    public init(title: String) {
        self.title = title
    }
    
    public init(title: String,
                parent: ExpandableItem) {
        self.title = title
        self.parent = parent
    }
    
    public init(title: String,
                parent: ExpandableItem,
                indentLevel: Int) {
        self.title = title
        self.parent = parent
    }
    
    // MARK: - Hashables
    
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
