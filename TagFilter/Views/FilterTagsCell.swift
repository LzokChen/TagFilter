//
//  FilterCategoryTableViewCell.swift
//  TagFilter
//
//  Created by Xiaojian Chen on 9/26/20.
//

import UIKit
import TagListView

protocol FilterTagsCellDelegate: AnyObject {
    func didSelectTag(category: String, tag: String)
    func didUnselectTag(category: String, tag: String)
}

class FilterTagsCell: UITableViewCell {

    @IBOutlet weak var categoryLabel : UILabel!
    @IBOutlet weak var buttonsView: TagListView!
    
    static let identifier = "FilterTagsCell"
    
    weak var delegate:FilterTagsCellDelegate?
    var categoryName: String?
    var tags: [String]?
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buttonsView.delegate = self
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

//MARK: - TagListViewDelegate
extension FilterTagsCell: TagListViewDelegate{
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        if !tagView.isSelected{
            delegate?.didSelectTag(category: categoryName!, tag: title)
        }else{
            delegate?.didUnselectTag(category: categoryName!, tag: title)
        }
        
        tagView.isSelected = !tagView.isSelected
        
    }
}
