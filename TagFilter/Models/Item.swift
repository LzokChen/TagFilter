//
//  Item.swift
//  TagFilter
//
//  Created by Xiaojian Chen on 9/23/20.
//

import Foundation

class Item : Equatable, Hashable {
    
    let name: String
    let uniqueProperties: [String:String]
    let filterTags: [String:[String]]
    
    init(name: String, uniqueProperties: [String:String], filterTags: [String:[String]]) {
        self.name = name
        self.uniqueProperties = uniqueProperties
        self.filterTags = filterTags
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name
    }
    
    public func hash(into hasher: inout Hasher) {
             hasher.combine(ObjectIdentifier(self).hashValue)
    }
    
}

