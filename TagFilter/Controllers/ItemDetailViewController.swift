//
//  ItemDetailViewController.swift
//  TagFilter
//
//  Created by Xiaojian Chen on 9/29/20.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var itemImageView : UIImageView!
    @IBOutlet weak var itemDescriptionTextView : UITextView!
    
    var selectedItem : Item?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let item = selectedItem{
            nameLabel.text = item.name
            itemDescriptionTextView.text = ""
            for description in Array(item.uniqueProperties).sorted(by: { (arg0, arg1) -> Bool in
                return arg0.key < arg1.key})
            {
                itemDescriptionTextView.text.append(description.key + ": " + description.value)
                itemDescriptionTextView.text.append("\n")

            }
            
            itemDescriptionTextView.text.append("\n" + "Tags: ")
            for category in Array(item.filterTags).sorted(by: { (arg0, arg1) -> Bool in
                return arg0.key < arg1.key})
            {
                itemDescriptionTextView.text.append(category.key + ": ")
                for tag in category.value{
                    itemDescriptionTextView.text.append(tag + " ")
                }
                itemDescriptionTextView.text.append("\n")
            }


        }else{
            fatalError("Nil Item for ItemDetailView")
        }
    }
    



}
