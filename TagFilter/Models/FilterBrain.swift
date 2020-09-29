//
//  FilterBrain.swift
//  TagFilter
//
//  Created by Xiaojian Chen on 9/23/20.
//

import Foundation
import SwiftyJSON

struct FilterBrain {
    private var itemsTitle: String?,
                uniquePropertiesTitle: String?,
                filterTagsTitle: String?
    var  filterTags = [String:[String]]()
    
    private var items = Set<Item>()
    var itemsByGroups = [String:[String:Set<Item>]]()
    
    
    //MARK: - Parse data.json
    //parse JSON file: Format part and Items part
    mutating func parseJSON(with jsonObj: JSON) -> Bool{
        let parseJSONFormatResult = parseJSONFormat(with: jsonObj)
        if parseJSONFormatResult {
            return parseJSONItems(with: jsonObj)
        }else
        {return false}
    }
    
    mutating func parseJSONFormat(with jsonObj: JSON) -> Bool{
        if let itemsT =  jsonObj["format"]["itemsTitle"].string,
           let uniquePropT = jsonObj["format"]["uniquePropertiesTitle"].string,
           let ftrTagsT = jsonObj["format"]["filterTagsTitle"].string,
           let ftrTags = jsonObj["format"]["filterTags"].dictionaryObject as? [String:[String]]
        {
            self.itemsTitle = itemsT
            self.uniquePropertiesTitle = uniquePropT
            self.filterTagsTitle = ftrTagsT
            self.filterTags = ftrTags
        }else{
            print("Failed to parese the data JSON file format part")
            return false
        }
        //print(uniquePropertiesTitle!)
        //print(filterTagsTitle!)
        //print(filterTags!)
        return true
    }
    
    mutating func parseJSONItems(with jsonObj: JSON) -> Bool{
        if let itemsDictionary = jsonObj[self.itemsTitle!].array {
            for itemDict in itemsDictionary {
                if let itemName = itemDict["name"].string,
                   let itemUniqueProperties = itemDict[self.uniquePropertiesTitle!].dictionaryObject as? [String:String],
                   let itemFilterTags = itemDict[self.filterTagsTitle!].dictionaryObject as? [String:[String]]{
                    let newItem = Item(name: itemName, uniqueProperties: itemUniqueProperties, filterTags: itemFilterTags)
                    self.items.insert(newItem)
                    //print(newItem.name)
                }else{
                    print("Failed to parese the data JSON file items part")
                    return false
                }
            }
        }
        return true
    }
    
    //MARK: - Classify all items to groups by tag
    //create entry for the itemGroups of each tag
    mutating func initializeItemGroups(){
        for tagCategory in self.filterTags{
            let tagCategoryName = tagCategory.key
            
            var newCategory : [String: Set<Item>] = [:]
            for tag in tagCategory.value{
                newCategory[tag] = []
            }
            self.itemsByGroups[tagCategoryName] = newCategory
        }
    }
    
    mutating func itemClassificationByTags(){
        self.initializeItemGroups()
        for item in items{
            for tagCategory in item.filterTags{
                let categoryName = tagCategory.key
                for tag in tagCategory.value{
                    self.itemsByGroups[categoryName]?[tag]?.insert(item)
                }
            }
        }
    }
    
    //MARK: - Filter Function
    func filterByTags(with groups: [String : [String]]) -> Set<Item>{
        //groups format: [category1: [tag1, tag2 ...], category2 : [tag3, tag4] ....]
        var result = Set<Item>()
        for group in groups{
            let categoryName = group.key, tags = group.value
            if !tags.isEmpty{
                var resultFilteredByCurrentGroup = Set<Item>()
                for tagName in tags{
                    let newGroup = itemsByGroups[categoryName]![tagName]!
                    resultFilteredByCurrentGroup = resultFilteredByCurrentGroup.union(newGroup)
                }
                if result.isEmpty{
                    result = resultFilteredByCurrentGroup
                }else{
                    result = result.intersection(resultFilteredByCurrentGroup)
                }
                
                if result.isEmpty{ //empty after intersection
                    return result
                }
            }
        }
        return result
    }
}

