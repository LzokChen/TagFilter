//
//  FilterCategoryTableViewCell.swift
//  TagFilter
//
//  Created by Xiaojian Chen on 9/26/20.
//

import UIKit
import TagListView

protocol FilterTagsCellDelegate {
    func didTapTag(category: String, tag: String)
}

class FilterTagsCell: UITableViewCell {

    @IBOutlet weak var categoryLabel : UILabel!
    @IBOutlet weak var buttonsView: TagListView!
    
    static let identifier = "FilterButtonsCell"
    
    var categoryName: String?
    var tags: [String]?
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    func configure(with dictionaryObj: Dictionary<String, [String]>.Element){
        categoryName = dictionaryObj.key
        categoryLabel.text = categoryName
        tags = dictionaryObj.value
        
        buttonsView.textFont = UIFont.systemFont(ofSize: 18)
        buttonsView.alignment = .left
        
        buttonsView.addTags(tags!)
        
        
    }

    
}
