//
//  Folder.swift
//  ExpandableCollectionViewKit
//
//  Created by Astemir Eleev on 06/10/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import Foundation

@_functionBuilder
struct ExpandableItemBuilder {
    static func buildBlock(_ subitems: ExpandableItem...) -> [ExpandableItem] {
        subitems
    }
}


class ExpandableItemFolder: ExpandableItem {
    
    var title: String
    private(set) var subitems: [ExpandableItem] = []
    
    var isExpanded: Bool = false
    
    var isGroup: Bool {
        return subitems.count > 0
    }
    
    init(title: String,
         isExpanded: Bool = false) {
        self.title = title
        super.init()
        self.isExpanded = isExpanded
    }
    
    init(title: String,
         isExpanded: Bool = false,
         @ExpandableItemBuilder subitems: () -> [ExpandableItem]) {
        self.title = title
        super.init()
        self.isExpanded = isExpanded
        
        let subitems = subitems()
        subitems.setParent(self)
        self.subitems = subitems
    }
    
    init(title: String,
         isExpanded: Bool = false,
         @ExpandableItemBuilder subitems: () -> ExpandableItem) {
        self.title = title
        super.init()
        self.isExpanded = isExpanded
        
        let subitems = [subitems()]
        subitems.setParent(self)
        self.subitems = subitems
    }
    
    // MARK: - Methods
    
    @discardableResult
    func remove(at index: Int) -> Self {
        subitems.remove(at: index)
        return self
    }
    
    @discardableResult
    func addItems(_ items: [ExpandableItem]) -> Self {
        items.setParent(self)
        subitems += items
        return self
    }
}
